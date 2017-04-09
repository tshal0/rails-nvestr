class UsersController < ApplicationController

	def show
		# Profile page
		Rails.logger.info(params)
		@user = User.find_by(user_name: params[:id])
		@current_user = User.find(session[:user_id])
		@is_admin = false
		if @user.id == @current_user.id || @current_user.is_admin then
			@is_admin = true
			@header_attribs = ['Username', 'Email', 'New Password']
			@all_attribs = ['user_name', 'email', 'password']
		end
		respond_to do |format|
			format.html {}
		end
	end

	def create
		@user = User.new(user_params)

		Rails.logger.info(@user)
		if @user.save
			# TODO: cache the user id for the session. 
			session[:user_id] = @user.id
			if params[:role] then
				@user.add_role(Role.find(params[:role]))
			else
				@user.add_role(Role.find_by(role_name: "admin"))
			end
			
			Portfolio.create(portfolio_name: 'Portfolio', user_id: @user.id, portfolio_cash_account: 100000.00)
			# Need a logged-in landing page. 
			redirect_to user_path(:id => @user.user_name)
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
		@header_attribs = ['Username', 'Email', 'New Password']
		@all_attribs = ['user_name', 'email', 'password']

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

	def update_user_roles
		# params[:role_check] is the array of enabled roles. 
		role_checks = params[:role_check]

		if role_checks.empty? then
		else
			UserToRole.where(:user_id => params[:user_id]).destroy_all
			role_checks.each do |role_id|
				UserToRole.create(user_id: params[:user_id], role_id: role_id)
			end
		end
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
