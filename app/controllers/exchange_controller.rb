# Created by Thomas Shallenberger 3/17
# Purpose: Provide implementation for Exchange page to allow
# users to create trades affecting or creating positions in their
# portfolios. 


Quandl::ApiConfig.api_key = 'xNSxrMU_zRKHVD-7TKxJ'
Quandl::ApiConfig.api_version = '2015-04-09'

require 'open-uri'
require 'zip'

class ExchangeController < ApplicationController

	def view
		@stocks = Stock
			.where.not(stock_name: '', industry: '', sector: '', price_update: nil, stock_price: nil)
			.pluck(:id, :stock_name, :sector, :industry, :stock_symbol, :stock_price, :price_update)
			
		@headers = ['Company Name', "Sector", "Industry", "Symbol", "Price", "Last Updated", "Actions"]
		@attribs = ['stock_name', 'stock_symbol', 'stock_price']


		respond_to do |format|
			format.html {}
		end
	end

	def import
		

	end

	def refresh

		rowarray = Array.new    
    	myfile = params[:file]

    	csv = CSV.read(myfile.path)

		
		
		csv.each do |first, sec|
			name = sec.split("(", 2).first
			sym = first.split("/", 2).last
			Rails.logger.info(sym + " : " + name)

			if !Stock.exists?(:stock_symbol => sym) then
				stock = Stock.new(stock_symbol: sym, stock_name: name, stock_price: 0)
				stock.save
			elsif Stock.find_by(stock_symbol: sym).stock_price == 0
				dataset = Quandl::Dataset.get(first)
				latest = dataset.newest_available_date
				price = dataset.data(params: {start_date: latest, column_index:4}).values[0].close
				Stock.find_by(stock_symbol: sym).update_column("stock_price", price)
			end



		end
		redirect_to exchange_path
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
