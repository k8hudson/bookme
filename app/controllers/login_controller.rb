class LoginController < ApplicationController

  def new_session
    @user = User.new
  end

  def create_session
    if env['omniauth.auth']
      user = User.from_omniauth(env['omniauth.auth'])
    else
      user = User.find_by(email: params[:user][:email])
      unless user && user.authenticate(params[:user][:password])
        user = nil
      end
    end

    if user
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = "Incorrect password."
      redirect_to login_path
    end
  end

  def logout
    reset_session
    redirect_to login_path
  end

  # def signin_redirect
  #   if !signed_in? 
  #     redirect_to logout_path
  #   end
  # end

end