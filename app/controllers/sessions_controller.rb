class SessionsController < ApplicationController
	def new
		respond_to do |format|
      		format.js {} # renders new.js.erb
    	end
	end

	# When Dangerous attempts to LOGIN from modal, requesting new session. 
	def create
		# Users can attempt to login via EMAIL or USERNAME. 
		# 
		user_by_email = User.find_by(email: params[:session][:name].downcase)
		user_by_username = User.find_by(username: params[:session][:name].downcase)

		if user_by_email && user_by_email.authenticate(params[:session][:password])
			@user = user_by_email
		elsif user_by_username && user_by_username.authenticate(params[:session][:password])
			@user = user_by_username
		else
			# Username NOT FOUND.  
			@login_error = 'USERNAME_NOT_FOUND'

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
			redirect_to portfolio_path
		end

end
