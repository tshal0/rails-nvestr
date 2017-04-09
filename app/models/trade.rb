class Trade < ActiveRecord::Base
	def type
		return TradeType.find(self.trade_type).trade_type_name
	end

	def current_price
		return Stock.find(self.stock_id).stock_price
	end

	def change
		current_price = self.current_price
		change = self.trade_price - current_price
		return change
	end
end
