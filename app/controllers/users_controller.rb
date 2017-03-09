class UsersController < ApplicationController

	def new
	end

	def create
		@user = User.new(user_params)
		Rails.logger.info(@user)
		if @user.save
			# TODO: cache the user id for the session. 
			session[:user_id] = @user.id
			# Need a logged-in landing page. 
			redirect_to root_path
		else
			# Unsuccessful login. 
			Rails.logger.info(@user.errors.full_messages)

		end

		respond_to do |format|
			format.js {}
		end
	end

	def edit
	end

	def update
	end

	# method to delete user. 
	def delete
		# How does the user id get here?

		User.find(params[:id]).destroy
		
	end

	# launch modal for adding user. 
	def add_user
		@user = User.new 
		@header_attribs = ['user_name', 'Email', 'Password']
		@all_attribs = ['user_name', 'email', 'password']
		respond_to do |format| 
			format.js {}
		end
	end


	private
		# Require/permit user_name|email|password for initial registration
		def user_params
			params.require(:user).permit(
				:user_name, 
				:email,
				:password)
		end

	
end
