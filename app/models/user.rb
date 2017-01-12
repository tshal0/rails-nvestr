class User < ActiveRecord::Base

	# Added for BCrypt
	has_secure_password
	# Not sure what these are for or when they come into play...
	validates :username, presence: true, length: {maximum: 20}
	validates :password, presence: true, length: {minimum: 6}, :on => :create

end
