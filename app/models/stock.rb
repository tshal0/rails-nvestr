class Stock < ActiveRecord::Base
	def to_param
		stock_symbol
	end

	def update_price(price)
		self.stock_price = price
		puts price
	end
end


