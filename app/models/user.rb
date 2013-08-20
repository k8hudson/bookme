class User < ActiveRecord::Base
	has_secure_password
	has_many :events
	has_many :providers, through: :events

	def self.from_omniauth(auth)
    	where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	      user.provider = auth.provider
	      user.uid = auth.uid
	      user.username = auth.info.name
	      user.password = auth.credentials.token
	      user.password_confirmation = auth.credentials.token
	      #user.handle = auth.info.name
	      user.oauth_token = auth.credentials.token
	      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	      user.save!
	    end
  	end
end
