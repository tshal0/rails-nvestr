class Position < ActiveRecord::Base
	def value
		stock = Stock.find(self.stock_id)
		return self.position_amount * stock.stock_price
	end
end
