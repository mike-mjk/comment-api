class User < ApplicationRecord
	has_many :messages, dependent: :destroy
	has_many :likes, dependent: :destroy
end
