# Created by: Thomas Shallenberger 3/8/2017
# Purpose: 	Implement functionality to add/update Stock entries in the database, 
# 			and provide modals for users to update data manually. 

class StocksController < ApplicationController
  
	def new
	end

	def create
		@stock = Stock.new(stock_params)
		if @stock.save
		else
		end

		respond_to do |format|
			format.js { redirect_to manage_stocks_path }
		end
	end

	def delete
		Stock.find(params[:id]).destroy
	end

	def add_stock
		@stock = Stock.new
		@headers = ['Company Name', "Symbol", "Price"]
		@attribs = ['stock_name', 'stock_symbol', 'stock_price']
		respond_to do |format|
			format.js {}
		end
	end

	def update_stock
		@stock = Stock.find(params[:stock_id])
		@headers = ['Company Name', "Symbol", "Price"]
		@attribs = ['stock_name', 'stock_symbol', 'stock_price']

		respond_to do |format|
			format.js {}
		end

	end

	def edit_stock

		@stock = Stock.find_by(stock_symbol: params[:stock][:stock_symbol])
		@stock.update_attributes(stock_params)


		respond_to do |format|
			format.js {}
		end

	end

	private
		def stock_params
			params.require(:stock).permit(
				:stock_name,
				:stock_symbol,
				:stock_price)
		end


end
