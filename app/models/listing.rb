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

  def self.search(search_query)
    listings = nil

    if !search_query.nil?
      listings = self.where('title ~* ? OR description ~* ?',
                            search_query,
                            search_query)
    else
      listings = self.all
    end

    return listings.order 'created_at DESC'
  end
end
