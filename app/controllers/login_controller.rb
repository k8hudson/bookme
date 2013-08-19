class LoginController < ApplicationController
  def new_session
    @login_form = LoginForm.new
    @provider = Provider.new
  end

  def create_session


    if env['omniauth.auth']
      provider = Provider.from_omniauth(env['omniauth.auth'])
    else
      login_form = LoginForm.new(email: params[:login_form][:email], password: params[:login_form][:password])
      account = login_form.login
    end

    if login_form.account
      session[:provider_id] = account.id
      redirect_to login_form.homepage_path
      # Was: redirect_to provider_path(provider)
    else
      flash[:error] = "Incorrect password."
      redirect_to login_path
    end
  end



  def logout
    reset_session
    redirect_to login_path
  end
end