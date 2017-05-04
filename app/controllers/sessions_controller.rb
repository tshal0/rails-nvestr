class SessionsController < ApplicationController
	def new

		@user = User.new

		@required_user_attributes = ["user_name",
			"email",
			"password"
		]

		@header_user_attributes = ["User Name:",
			"Email:",
			"Password:"
		]

		@roles = Role.all

		respond_to do |format|
      		format.html {} # renders new.html.erb
    	end
	end

	# When Dangerous attempts to LOGIN from modal, requesting new session. 
	def create
		# Users can attempt to login via EMAIL or user_name. 
		# 
		user_by_email = User.find_by(email: params[:session][:email].downcase)
		user_by_user_name = User.find_by(user_name: params[:session][:email].downcase)

		if user_by_email && user_by_email.authenticate(params[:session][:password])
			Rails.logger.info("EMAIL")
			@user = user_by_email
		elsif user_by_user_name && user_by_user_name.authenticate(params[:session][:password])
			Rails.logger.info("NAME")
			@user = user_by_user_name
		else
			# user_name NOT FOUND.  
			@login_error = 'user_name_NOT_FOUND'
			Rails.logger.info("NOT FOUND")

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
