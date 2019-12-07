class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :message
  validates :user, :message, presence: true
  validates :content, length: {minimum: 10}
end
