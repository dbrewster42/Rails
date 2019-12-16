class Event < ApplicationRecord
  belongs_to :user
  has_many :attendees, through: :members, source: :user
  has_many :members, dependent: :destroy
  # has_many :members, through: :events, source: :user
  has_many :comments, dependent: :destroy  
  validates :name, :date, :user, presence: true
  validates :state, length: { is: 2 }
  validate :date_validation
  before_save { self.state.upcase! unless self.state.blank? }
  private
  def date_validation
  	if date.present? && date < Date.today
  		errors.add(:date, ": You must pick a future date")
  	end
  end
end
