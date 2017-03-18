# Created by Thomas Shallenberger 3/17
# Purpose: Provide implementation for Exchange page to allow
# users to create trades affecting or creating positions in their
# portfolios. 

class ExchangeController < ApplicationController

	def view

		respond_to do |format|
			format.html {}
		end
	end

	def create_trade 
		# Get all stocks, portfolio ID, user info, etc. 
		@trade = Trade.new
		@stocks = Stock.all
		Rails.logger.info(session)
		respond_to do |format|
			format.js {}
		end
	end

end
