class User < ApplicationRecord
	has_many :messages
	has_many :comments
	validates :name, length: { minimum: 6}, uniqueness: true
end
