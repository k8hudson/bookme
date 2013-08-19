class LoginForm
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_accessor :email
  attr_accessor :password
	attr_accessor :account

  def initialize(args = {})
    @email = args[:email]
    @password = args[:password]
    @account = nil
  end

  def login
    return nil if email.blank? || password.blank?

    self.account = find_account
    unless account && self.account.authenticate(password)
      self.account = nil
    end
 
    # puts "[login_form] account = #{self.account.inspect}"
    # puts "[login_form] Authentication result = #{self.account.authenticate(password)}"
    # puts "[login_form] homepage_path = #{homepage_path}"
    self.account
  end

  def homepage_path
    # send("#{account.class.to_s.downcase}_path", account.id)
    # In console: app.send("#{account.class.to_s.downcase}_path", account.id)
    
    # puts "[login_form] user_path = #{Rails.application.routes.url_helpers.user_path(1)}"
    # puts "[login_form] provider_path = #{Rails.application.routes.url_helpers.provider_path(1)}"
    # puts "[homepage_path] account.class = #{account.class}"
    if account.is_a? User
      Rails.application.routes.url_helpers.user_path(account.id)
    elsif account.is_a? Provider
      Rails.application.routes.url_helpers.provider_path(account.id)
    end
  end

  # def model_name
  #   "LoginForm"
  # end

	private

	def find_account
      Provider.find_by(email: email) || User.find_by(email: email)
	end
end