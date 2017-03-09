class User < ActiveRecord::Base
	has_secure_password

	def add_role(role)
		# Create UTR 
		UserToRole.create(user_id: self.id, role_id: role.id)
	end
end
