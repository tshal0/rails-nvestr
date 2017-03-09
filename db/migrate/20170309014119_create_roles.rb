# Created by Thomas Shallenberger 3/8/2017
# Purpose: Provide roles for users to access/perform certain things


class CreateRoles < ActiveRecord::Migration
  def change
    
    create_table :roles do |t|
    	t.string :role_name

		t.timestamps null: false
    end
  end
end
