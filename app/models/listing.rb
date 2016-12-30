class Listing < ApplicationRecord
  validates :title, :description, :price, presence: true

  validates :title, length: { minimum: 2, maximum: 50 }

  validates :description, length: { minimum: 2, maximum: 400 }

  validates :price, numericality: { only_integer: true, minimum: 0,
                                    greater_than: 0,
                                    less_than_or_equal_to: 1_000_000 }

  validates :user, presence: true

  belongs_to :user

  # image uploading
  mount_uploaders :listingimages, ListingImagesUploader
end
