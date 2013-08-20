class Provider < ActiveRecord::Base
	has_secure_password
	has_many :events
	has_many :users, through: :events

	validates :pname, :category, presence: true
	validates :email, uniqueness: true, presence: true,
                       format: {
                         with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i,
                         message: "must be formatted correctly."
                       }
end
