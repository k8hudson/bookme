class LoginController < ApplicationController
  def new_session
    @provider = Provider.new
  end

  def create_session
    if env['omniauth.auth']
      provider = Provider.from_omniauth(env['omniauth.auth'])
    else
      provider = Provider.find_by(email: params[:provider][:email])
      unless provider && provider.authenticate(params[:provider][:password])
        provider = nil
      end
    end

    if provider
      session[:provider_id] = provider.id
      redirect_to provider_path(provider)
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