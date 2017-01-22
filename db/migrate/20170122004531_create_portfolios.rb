class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :portfolios, :user_id

  end
end
