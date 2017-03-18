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
		@stocks = Stock.all
		@headers = ['Company Name', "Symbol", "Price", "Last Updated", "Actions"]
		@attribs = ['stock_name', 'stock_symbol', 'stock_price']

		respond_to do |format|
			format.html {}
		end
	end

	def manage_portfolios
	end

	


end
