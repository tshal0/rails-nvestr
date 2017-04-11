# Created by Thomas Shallenberger 3/17
# Purpose: Provide implementation for Exchange page to allow
# users to create trades affecting or creating positions in their
# portfolios. 

class ExchangeController < ApplicationController

	def view
		@stocks = Stock.all
		@headers = ['Company Name', "Symbol", "Price", "Last Updated", "Actions"]
		@attribs = ['stock_name', 'stock_symbol', 'stock_price']


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

	def execute_trade

		Rails.logger.info(trade_params)

		# Find all the records needed for this trade. 

		@error = "NONE"

		stock = Stock.find(params[:trade][:stock_id])

		portfolio = Portfolio.find_by(user_id: session[:user_id])

		trade_type = TradeType.find(params[:trade][:trade_type])

		# Check if the position exists, in case we need to create a new one. 
		if (Position.exists?(:portfolio_id => portfolio.id, :stock_id => stock.id)) then
			position = Position.find_by(portfolio_id: portfolio.id, stock_id: stock.id)
		elsif trade_type.trade_type_name != "SELL" then
			position = Position.new(portfolio_id: portfolio.id, stock_id: stock.id, position_amount: 0)
		else
			# Tried to sell shares we don't have. 

			@error = "Position does not exist."
			Rails.logger.info(@error)
			respond_to do |format|
				format.js {}
			end
		end

		
		params[:trade][:trade_datetime] = DateTime.current
		# Check if we're using market price or queueing a trade. 
		if params[:price] == "true" then
			params[:trade][:trade_price] = stock.stock_price
		end



		trade = Trade.new(trade_params)
		
		# Modify the positions accordingly



		if trade_type.trade_type_name == "BUY" then
			# We need more checks here to make sure shit doesn't break

			if (stock.stock_price * trade_params[:trade_amount].to_d) < portfolio.portfolio_cash_account then
				Rails.logger.info(portfolio.total_value)
				Rails.logger.info(position)
				position.position_amount += trade_params[:trade_amount].to_d

				portfolio.portfolio_cash_account -= (stock.stock_price * trade_params[:trade_amount].to_d)
				Rails.logger.info(portfolio.total_value)
			else
				# Can't afford the trade. what do
				@error = "Not enough funds for this trade."
				respond_to do |format|
					format.js {}
				end
			end

			
		elsif trade_type.trade_type_name == "SELL" then

			if (trade_params[:trade_amount].to_d <= position.position_amount) then
				Rails.logger.info(portfolio.total_value)
				portfolio.portfolio_cash_account += (trade_params[:trade_amount].to_d * stock.stock_price)
				position.position_amount -= trade_params[:trade_amount].to_d
				Rails.logger.info(portfolio.total_value)
			else
				# Not enough shares to sell. 
				@error = "Not enough shares to cover this trade."
				 respond_to do |format|
					format.js {}
				end
			end
		else
		end

		if @error == "NONE"
			position.save
			trade.position_id = position.id
			trade.save
			portfolio.save
		end


		respond_to do |format|
			format.js {}
		end
	end

	private 
		def trade_params
			params.require(:trade).permit(
				:position_id,
				:stock_id,
				:trade_type,
				:trade_price,
				:trade_amount,
				:trade_datetime
			)	
		end
end
