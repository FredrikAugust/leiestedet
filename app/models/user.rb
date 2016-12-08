# Main user, used for auth
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true

  validates :first_name, length: { minimum: 1, maximum: 30 },
    format: { with: /\A[\w\-\'\s]+\z/ }

  validates :last_name, length: { minimum: 1, maximum: 30 },
    format: { with: /\A[\w\-\'\s]+\z/ }

  has_many :listings, dependent: :destroy
end
