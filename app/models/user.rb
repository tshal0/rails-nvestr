class User < ActiveRecord::Base
	has_secure_password
	validates :user_name, uniqueness: true
	validates :email, uniqueness: true
	def add_role(role)
		# Create UTR 
		Rails.logger.info("SELF: " + self.id.to_s)
		Rails.logger.info("ROLE: " + role.id.to_s)
		UserToRole.create(user_id: self.id, role_id: role.id)
	end

	def has_role(role)
		return UserToRole.exists?(:user_id => self.id, :role_id => role.id)
	end

	def is_admin
		return true
	end

	def to_param
		user_name
	end
end
