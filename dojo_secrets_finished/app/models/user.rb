class User < ApplicationRecord
  has_secure_password
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :liked_secrets, through: :likes, source: :secret
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :email, presence: true
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
  before_save { self.email.downcase! unless self.email.blank? }
  #  def email_lowercase
  #   email.downcase!
  # end
end
