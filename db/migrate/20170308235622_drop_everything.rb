class DropEverything < ActiveRecord::Migration
  def up 
  	# I hope this removes indexes too. 

  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
