class AddCashAccountToPortfolio < ActiveRecord::Migration
  def change
  	add_column :portfolios, :portfolio_cash_account, :decimal
  end
end
