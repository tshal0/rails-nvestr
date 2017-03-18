class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|

    	t.string :trade_type
    	t.decimal :trade_amount
    	t.decimal :trade_price
    	t.datetime :trade_datetime
    	t.integer :stock_id
    	t.integer :position_id

      t.timestamps null: false
    end
  end
end
