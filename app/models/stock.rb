class Stock < ActiveRecord::Base
	def to_param
		stock_symbol
	end
end
