# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Default Users: user_name, email, password. 

default_users = [
["thomas", "thomas@gmail.com", "secret"],
["brooklyn", "brooklyn@gmail.com", "secret"]
]

default_users.each do |user_name, email, password|
	User.create(user_name: user_name, email: email, password: password)
end

# Default Portfolios: portfolio_name, user_id

default_portfolios = [
	["Test Portfolios", User.find_by(user_name: "thomas").id]
]

default_portfolios.each do |portfolio_name, user_id|
	Portfolio.create(portfolio_name: portfolio_name, user_id: user_id)
end

# Default Stocks: stock_name, stock_symbol, stock_price

default_stocks = [
	["Google", "GOOG", 50]
]

default_stocks.each do |stock_name, stock_symbol, stock_price|
	Stock.create(stock_name: stock_name, stock_symbol: stock_symbol, stock_price: stock_price)
end

# Default Trades: trade_type, trade_amount, trade_price, trade_datetime, stock_id, position_id

default_trades = [
	["BUY", 100, 50, DateTime.current, Stock.find_by(stock_symbol: "GOOG").id, 1]
]

default_trades.each do | trade_type, trade_amount, trade_price, trade_datetime, stock_id, position_id |
	Trade.create(trade_type: trade_type, trade_amount: trade_amount, trade_price: trade_price, trade_datetime: trade_datetime, stock_id: stock_id, position_id: position_id)
end

# Default Positions: position_amount, stock_id, portfolio_id

default_positions = [
	[100, Stock.find_by(stock_symbol: "GOOG").id, Portfolio.find_by(portfolio_name: "Test Portfolios").id]
]

default_positions.each do |position_amount, stock_id, portfolio_id|
	Position.create(position_amount: position_amount, stock_id: stock_id, portfolio_id: portfolio_id)
end



