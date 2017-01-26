# Controller for admin capabilities and dashboard


class AdminController < ApplicationController

	def dashboard

		respond_to do |format|
			format.html {}
		end

	end



end
