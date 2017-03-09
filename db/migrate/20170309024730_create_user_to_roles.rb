class CreateUserToRoles < ActiveRecord::Migration
  def change
    create_table :user_to_roles do |t|

		t.integer :user_id
		t.integer :role_id
		t.timestamps null: false
    end
  end
end
