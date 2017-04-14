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

	def import

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
