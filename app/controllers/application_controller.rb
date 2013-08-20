class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    
  # got these tips from
  # http://lyconic.com/blog/2010/08/03/dry-up-your-ajax-code-with-the-jquery-rest-plugin
  before_filter :correct_safari_and_ie_accept_headers
  after_filter :set_xhr_flash
 
  def set_xhr_flash
    flash.discard if request.xhr?
  end

  def correct_safari_and_ie_accept_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end  


  def check_provider_login
    if session[:provider_id]
      @current_provider = Provider.find(session[:provider_id])
    else
      redirect_to login_path
    end
  end
  
  def check_user_login
    if session[:user_id] 
      @current_user ||= User.find(session[:user_id])
      #gon.current_user_id = @current_user.id
    else
      redirect_to login_path
    end
  end

end
