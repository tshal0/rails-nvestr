class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name

      t.integer :user_id

      t.timestamps null: false
    end

    add_index :roles, :user_id

  end
end
