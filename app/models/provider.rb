class Provider < ActiveRecord::Base
	has_secure_password
	has_many :events
	has_many :users, through: :events
end
