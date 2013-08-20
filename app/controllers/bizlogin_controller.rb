class BizloginController < ApplicationController
  def new_session
    @provider = Provider.new
  end

  def create_session
    provider = Provider.find_by(email: params[:user][:email])

    if provider && provider.authenticate(params[:user][:password])
      session[:provider_id] = provider.id
      redirect_to provider_path(provider)
    else
      flash[:error] = "Incorrect password."
      redirect_to bizlogin_path
    end
  end

  def logout
    reset_session
    redirect_to bizlogin_path
  end
end