class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|

    	t.string :stock_name
    	t.string :stock_symbol
    	t.decimal :stock_price
      t.timestamps null: false
    end
  end
end
