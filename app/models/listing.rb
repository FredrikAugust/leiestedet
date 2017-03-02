class Listing < ApplicationRecord
  validates :title, :description, :price, presence: true

  validates :title, length: { minimum: 2, maximum: 50 }

  validates :description, length: { minimum: 2, maximum: 400 }

  validates :price, numericality: { only_integer: true, minimum: 0,
                                    greater_than: 0,
                                    less_than_or_equal_to: 1_000_000 }

  validates :user, presence: true

  validate :validate_number_of_images

  belongs_to :user

  # image uploading
  mount_uploaders :listingimages, ListingImagesUploader

  def validate_number_of_images
    unless listingimages.count <= 5
      errors.add(:listingimages, "maks 5 bilder per annonse")
    end
  end

  def self.search(search_query, current_page)
    if search_query
      where('title ~* ? OR description ~* ?', search_query, search_query).paginate(page: current_page, per_page: 12).order('id DESC')
    else
      paginate(page: current_page, per_page: 12).order('id DESC')
    end
  end
end
