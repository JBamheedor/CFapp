class Comment < ApplicationRecord

  #Validations
  validates :body, presence: true
    validates :user, presence: true
    validates :product, presence: true
    # validates :rating, numerically: { only_integer: true }
  #Relationships
  belongs_to :user
  belongs_to :product

  scope :rating_desc, -> { order(rating: :desc) }

  scope :rating_asc, -> { order(rating: :asc) }
end
