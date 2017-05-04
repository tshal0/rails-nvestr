class SessionsController < ApplicationController
	def new
		respond_to do |format|
      		format.html {} # renders new.html.erb
    	end
	end

	# When Dangerous attempts to LOGIN from modal, requesting new session. 
	def create
		# Users can attempt to login via EMAIL or user_name. 
		# 
		user_by_email = User.find_by(email: params[:session][:name].downcase)
		user_by_user_name = User.find_by(user_name: params[:session][:name].downcase)

		if user_by_email && user_by_email.authenticate(params[:session][:password])
			@user = user_by_email
		elsif user_by_user_name && user_by_user_name.authenticate(params[:session][:password])
			@user = user_by_user_name
		else
			# user_name NOT FOUND.  
			@login_error = 'user_name_NOT_FOUND'

		end

		if @user
			# Save user ID in cookie to keep em logged in. 
			@login_error = 'NONE'
			login
		elsif @login_error 
			
		else
			@login_error = 'INVALID_PASSWORD'
		end

		respond_to do |format|
			format.js {} # should render create.js.erb
 		end
		 
		 
	end

	# Log out a user
	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
	
	private
		# private login method when creating a session. 
		def login
			session[:user_id] = @user.id
			# Redirect to user portfolio
			redirect_to user_path(:id => current_user.user_name)
		end

end
