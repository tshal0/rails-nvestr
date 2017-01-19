class User < ActiveRecord::Base

	# Added for BCrypt
	has_secure_password
	# Not sure what these are for or when they come into play...
	validates_uniqueness_of :username, :message => "is not available"
	validates_uniqueness_of :email, :message => "is not available"
	validates :email, presence: true, :on => :create
	validates :username, presence: true, length: {maximum: 20}
	validates :password, presence: true, length: {minimum: 6}, :on => :create

end
