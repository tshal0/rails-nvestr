class DropEverything < ActiveRecord::Migration
  def up 
  	# I hope this removes indexes too. 
  	drop_table :portfolios
  	drop_table :users
  	drop_table :roles
  	drop_table :stocks
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
