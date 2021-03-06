class ApplicationController < ActionController::Base
helper_method :header_cart, :locat, :okey
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
after_filter :store_location

def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  return unless request.get? 
  if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
    session[:previous_url] = request.fullpath 
  end
end

def after_sign_in_path_for(resource)
  session[:previous_url] || root_path
end

def after_sign_up_path_for(resource)
     session[:previous_url] || 'users/show'
end

def header_cart
     @header_cart ||=  session[:cart] || {}
end

def locat
	
	if (session[:locat] && session[:locat] != "")
		return session[:locat]	
	else if(current_user && current_user.add1 && current_user.add1 != "")
	  adra ="#{current_user.add1}, #{current_user.add2}, #{current_user.city} - #{current_user.zip}, #{current_user.state}"
	  adra.gsub! " - ,", ","
	  adra.gsub! ", -", ", PIN-"
	  adra.gsub! ", , ", ", "
	  return adra
	else
		return request.remote_ip
	end
	end
end

def okey(prestr, objct, postr)
if("#{objct}" == "")
prestr = ""
postr = ""
end
return "#{prestr}#{objct}#{postr}"	
end

  protected

  def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :state, :city, :zip, :add1, :add2, :contact, :contact2, :user_tnc, :service_tnc, :email, :password, :password_confirmation) }
  devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :state, :city, :zip, :add1, :add2, :contact, :contact2, :user_tnc, :service_tnc, :email, :password, :password_confirmation, :current_password) }
  end


  #def sitemap
    #path = Rails.root.join("public", "sitemaps", current_site.key, "sitemap.xml")
    #if File.exists?(path)
     # render xml: open(path).read
    #else
     # render text: "Sitemap not found.", status: :not_found
    #end
  #end

  #def robots
  #end

end
