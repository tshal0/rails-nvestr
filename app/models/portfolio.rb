class Portfolio < ActiveRecord::Base
	def stock_value
		stock_val = 0
		Position.where(portfolio_id: self.id).each do |position|
			stock = Stock.find(position.stock_id)
			stock_val += (position.position_amount * stock.stock_price)
		end

		return stock_val
	end

	def total_value
		total = self.stock_value
		return total + self.portfolio_cash_account
	end
end
