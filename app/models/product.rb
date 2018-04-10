class Product < ApplicationRecord
  #validation - requires all new products to match criteria below:
  validates :name, :color, :image_url, presence: true
  validates :description, length: { minimum: 10 }
  validates :price, numericality: { only_integer: true }

  has_many :orders
  has_many :comments

# Checking which environment production or development because Postgres matching operator LIKE is case sensitive
  def self.search(search_term)
    if Rails.env.production?
    Product.where("name ilike?", "%#{search_term}%")
    else
    Product.where("name LIKE ?", "%#{search_term}%")
    end
  end

  def highest_rating_comment
    comments.rating_desc.first
  end

  def lowest_rating_comment
    comments.rating_asc.first
  end

  def average_rating
    comments.average(:rating).to_f
  end

  def views
    $redis.get("product:#{id}")
  end

  def viewed
    $redis.incr("product:#{id}")
  end
end
