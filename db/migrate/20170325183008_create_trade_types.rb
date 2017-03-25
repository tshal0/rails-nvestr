class CreateTradeTypes < ActiveRecord::Migration
  def change
    create_table :trade_types do |t|

		t.string :trade_type_name
      t.timestamps null: false
    end

    remove_column :trades, :trade_type
    add_column :trades, :trade_type, :integer
  end
end
