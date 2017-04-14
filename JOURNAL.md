# 3/8

## New Branch
Purpose: 
Add new models to website
Add functionality to dynamically add/remove model entries to/from database
Add functionality to dynamically add/remove entities from their containers

### Log
First Goal:
1. Role
	role_name
2. UsersToRoles
	user_id
	role_id

Second Goal:
1. Stock
2. Trade
3. Position
4. Portfolio


	10:15 added migrations

Third Goal:
1. Role Selection in User Creation
2. Role Addition/Removal from User

Fourth Goal:
1. Add/Remove Stocks
2. Add/Remove Trades
3. Add/Remove Positions
4. Add/Remove Portfolios

# <Next Entry>


3/17

# Portfolio/Exchange

positions have:

position_amount
stock_id
portfolio_id

And are modified by Trades. 

Trades require: 
trade_type
trade_price
trade_amount
stock_id
position_id


3/21

Going to work on Position and Trades. Must create a Position by initializing the Position with a stock id, then immediately create a trade to modify that position. 

Must populate the Create Trade modal with a few things:

Stock Symbol
Trade Type dropdown
Price (Market or limit)
Sell Limit (stop loss)
Amount of shares (slider, with editable text box based on value in portfolio cash account)

That reminds me, I need to add portfolio cash value to the portfolio page. 

#################################




https://www.quandl.com/api/v3/datatables/WIKI/PRICES.json?api_key=xNSxrMU_zRKHVD-7TKxJ





















