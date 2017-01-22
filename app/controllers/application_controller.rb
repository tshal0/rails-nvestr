class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Allow us to use current_user in view files. 
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  # Send someone to login page if they try to access shit they not supposed to. 
  def authorized
  	redirect_to root_path unless current_user
  end

  def user_is_logged_in?
    if session[:user_id]
      return true
    else
      return false
    end
  end

  def is_admin
    if User.exists?(session[:user_id])
      return User.find(session[:user_id]).roles.exists?(name: 'admin')
    end
  end

  helper_method :user_is_logged_in?
  helper_method :is_admin

end
