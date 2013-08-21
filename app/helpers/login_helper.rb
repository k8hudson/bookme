module LoginHelper

def signed_in?
	 	!session[:user_id].nil? || !session[:provider_id].nil?
end
end


