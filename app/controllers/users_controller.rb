class UsersController < ApplicationController

	def new
	end

	def create
		@user = User.new(user_params)

		Rails.logger.info(@user)
		if @user.save
			# TODO: cache the user id for the session. 
			session[:user_id] = @user.id
			@user.add_role(Role.find(params[:role]))
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

	def manage_user
		@user = User.find_by(user_name: params[:user_name])
		@header_attribs = ['Username', 'Email']
		@all_attribs = ['user_name', 'email']
		respond_to do |format|

			format.js {}

		end
	end

	def edit_user
		Rails.logger.info(user_params)
		@user = User.find(params[:user][:id])
		@user.update_attributes(user_params)

		respond_to do |format|
			format.js {}
		end
	end

	def manage_roles
		@user = User.find_by(user_name: params[:user_name])
		@roles = Role.all
		@user_roles_bool = [];
		@roles.each do |role|
			@user_roles_bool.push(@user.has_role(role))
		end

		@user_roles = @roles.zip(@user_roles_bool)

		Rails.logger.info(@user_roles)
		
		respond_to do |format|
			format.js {}
		end
	end

	def update
	end

	# method to delete user. 
	def delete
		# How does the user id get here?

		User.find(params[:id]).destroy
		
	end

	def delete_user
		# delete the user, reload the table
		Rails.logger.debug(params[:user_name])
		User.find_by(user_name: params[:user_name]).destroy()
		respond_to do |format|
			format.js {}
		end
	end

	# launch modal for adding user. 
	def add_user
		@user = User.new 
		@header_attribs = ['Username', 'Email', 'Password']
		@all_attribs = ['user_name', 'email', 'password']
		respond_to do |format| 
			format.js {}
		end
	end


	private
		# Require/permit user_name|email|password for initial registration
		def user_params
			params.require(:user).permit(
				:id,
				:user_name, 
				:email,
				:password)
		end

	
end
