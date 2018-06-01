class UsersController < ApplicationController
	def my_contacts
		@users = User.all
		render :json => @users
	end
	def show
		@user = current_user
	end
	def edit
		@user = User.find params[:id]
		render partial:"edit"
	end
	def update
		user = User.find(params[:id])
	    user.update_attributes(user_params)
	    image = Image.create(image: params[:user][:images][:image], :imageable => user) if params[:user][:images].present?
	    flash[:notice] = "Profile updated."
	    redirect_to request.referrer
	end

	def image
		@user = User.find params[:id]
    	render :partial => "show_image"
	end

	private
	def user_params
    params.require(:user).permit(:first_name, :last_name, :image => [:image, :imageable])
  end
end
