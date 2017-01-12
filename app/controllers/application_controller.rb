class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Allow us to use current_user in view files. 
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  # Send someone to login page if they try to access shit they not supposed to. 
  def authorize 
  	redirect_to root_path unless current_user
  end


end
