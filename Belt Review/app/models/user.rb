class User < ApplicationRecord
  has_secure_password
  # belongs_to :event
  has_many :events
  has_many :comments
  has_many :members
  has_many :events_joined, through: :members, source: :event
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :state, length: { is: 2 }
  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
  before_save { self.state.upcase! unless self.state.blank? }
end
