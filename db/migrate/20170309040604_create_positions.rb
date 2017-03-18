class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|

    	t.decimal :position_amount
    	t.integer :stock_id
    	t.integer :portfolio_id
      t.timestamps null: false
    end
  end
end
