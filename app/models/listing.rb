class Listing < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2,
                                              maximum: 50 }
  validates :description, presence: true, length: { minimum: 2,
                                                    maximum: 400 }
  belongs_to :user
end
