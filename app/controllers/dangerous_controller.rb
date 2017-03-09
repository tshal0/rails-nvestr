class DangerousController < ApplicationController
	
	# Landing Page method
	def landing_page
		# Execute whatever before rendering landing_page.html.erb

		# Needs registration attribs:

		@required_user_attributes = ["user_name",
			"email",
			"password"
		]

		@header_user_attributes = ["user_name:",
			"Email:",
			"Password:"
		]

	end

	# Home page btn routes to this action. 
	def register_user
	end

	# Home page MENU BAR has a LINK to this action, which 
	# generates a MODAL allowing a user to LOGIN. 
	def login_modal
	end

	# The login MODAL has a btn that links to this action. 
	def login_user
	end

	# Home page btn routes to this action. Requests more info from us
	# personally. 
	def contact_us
	end

end
