class UsersController < ApplicationController
	before_action :authenticate_user!
	layout 'admin'

	def index
		
	end
	
	def show
		@user = User.find_by(id: [:id])
	end
end
