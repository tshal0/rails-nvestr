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

		stock = Stock.find(params[:trade][:stock_id])

		portfolio = Portfolio.find_by(user_id: session[:user_id])

		trade_type = TradeType.find(params[:trade][:trade_type])

		if (Position.exists?(:portfolio_id => portfolio.id, :stock_id => stock.id)) then
			position = Position.find_by(portfolio_id: portfolio.id, stock_id: stock.id)
		elsif trade_type.trade_type_name != "SELL" then
			position = Position.new(portfolio_id: portfolio.id, stock_id: stock.id)
		else
			# Tried to sell shares we don't have. 
			respond_to do |format|
				format.js {}
			end
		end

		if params[:price] == false then
			trade_params[:trade_price] = stock.stock_price
		end
		trade = Trade.new(trade_params)

		if trade_type.trade_type_name == "BUY" then
			# We need more checks here to make sure shit doesn't break
			position.position_amount += trade_params[:trade_amount].to_d
		elsif trade_type.trade_type_name == "SELL" then
			position.position_amount -= trade_params[:trade_amount].to_d
		else
		end
		trade.save
		position.save


		respond_to do |format|
			format.js {}
		end
	end

	private 
		def trade_params
			params.require(:trade).permit(
				:stock_id,
				:trade_type,
				:trade_price,
				:trade_amount
			)	
		end
end
