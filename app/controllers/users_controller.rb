class UsersController < ApplicationController
	def my_contacts
		@users = User.all
		render :json => @users
	end
end
