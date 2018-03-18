class Product < ApplicationRecord
  has_many :orders

# Checking which environment production or development because Postgres matching operator LIKE is case sensitive
  def self.search(search_term)
    if Rails.env.production?
    Product.where("name ilike?", "%#{search_term}%")
    else
    Product.where("name LIKE ?", "%#{search_term}%")
    end
  end
end
