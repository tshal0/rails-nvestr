# Created by Thomas Shallenberger 3-8-2017 
# because last model was dumb as fuck


class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	# user_name, email, password_digest ALL STRINGS THANK GOD

    	t.string :user_name
    	t.string :email
    	t.string :password_digest

		t.timestamps null: false
    end
  end
end
