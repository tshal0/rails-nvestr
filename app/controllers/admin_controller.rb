# Controller for admin capabilities and dashboard


class AdminController < ApplicationController

	def dashboard

		respond_to do |format|
			format.html {}
		end

	end

	# Controller methods for routing to admin pages 
	# used to manage settings for models
	def manage_users
		@users = User.all

		respond_to do |format|
			format.html {}
		end
	end

	def manage_roles
	end

	def manage_stocks
	end

	def manage_portfolios
	end

	def delete_user
		# delete the user, reload the table
		Rails.logger.debug(params[:user_name])
		User.find_by(user_name: params[:user_name]).destroy()
		respond_to do |format|
			format.js {}
		end
	end


end
