class AddingStockFields < ActiveRecord::Migration
  def change
  	change_table :stocks do |t|
	    t.string :industry
	    t.string :sector
	    t.decimal :open
	    t.integer :volume
	end
  end
end
