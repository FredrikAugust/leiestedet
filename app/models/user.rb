# Main user, used for auth
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, length: { minimum: 1, maximum: 30 },
    format: { with: /\A[\w\-\'\s]+\z/ }

  validates :last_name, length: { minimum: 1, maximum: 30 },
    format: { with: /\A[\w\-\'\s]+\z/ }

  validates :place_id, :location, length: { minimum: 1, maximum: 100 }

  validates :telephone, length: { minimum: 8, maximum: 14 },
    format: { with: /\A(\+\d{2}\s)?[\d\s]{8,10}\z/ }

  has_many :listings, dependent: :destroy
end
