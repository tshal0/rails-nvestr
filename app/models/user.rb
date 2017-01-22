class User < ActiveRecord::Base

	# Added for BCrypt
	has_secure_password

	# Database relationships

	has_many :roles
	has_many :portfolios

	validates_uniqueness_of :username, :message => "is not available"
	validates_uniqueness_of :email, :message => "is not available"
	validates :email, presence: true, :on => :create
	validates :username, presence: true, length: {maximum: 20}
	validates :password, presence: true, length: {minimum: 6}, :on => :create

end
