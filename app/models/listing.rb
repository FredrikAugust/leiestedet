class Listing < ApplicationRecord
  validates :title, :description, :location, :price, presence: true

  validates :title, length: { minimum: 2, maximum: 50 }

  validates :description, length: { minimum: 2, maximum: 400 }

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :user
end
