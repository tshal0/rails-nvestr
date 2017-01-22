class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :symbol
      t.decimal :price

      t.integer :portfolio_id

      t.timestamps null: false
    end

    # Stocks to Portfolio

    add_index :stocks, :portfolio_id

  end
end
