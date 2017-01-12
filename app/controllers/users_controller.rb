class UsersController < ApplicationController

	def new
	end

	def create
		@user = User.new(user_params)
		Rails.logger.info(@user)
		if @user.save
			# TODO: cache the user id for the session. 
			session[:user_id] = user.id
			# Need a logged-in landing page. 
		else
			# Unsuccessful login. 
			redirect_to root_path
		end
	end

	def edit
	end

	def update
	end

	def delete
	end

	def add_user
	end

	private
		# Require/permit username|email|password for initial registration
		def user_params
			params.require(:user).permit(
				:username, 
				:email,
				:password)
		end

	
end
