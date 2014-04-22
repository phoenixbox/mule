class User < ActiveRecord::Base
	validates :email, uniqueness: true, presence: true

	has_many :rooms
end
