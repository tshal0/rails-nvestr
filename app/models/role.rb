class Role < ActiveRecord::Base

	validates :role_name, uniqueness: true

end
