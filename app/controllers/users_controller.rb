class UsersController < ApplicationController
  before_filter :encrypt_id, :only => [:show, :block, :unblock]
  def my_contacts
    @users = User.all
    render :json => @users
  end
  def show
    if params[:id].present?
      @user = User.find params[:id]
    else
      @user = current_user
    end
  end
  def edit
    @user = User.find params[:id]
    render partial:"edit"
  end
  def update
    if params[:id] == current_user.id
      user = User.find(params[:id])
      user.update_attributes(user_params)
      image = Image.create(image: params[:user][:images][:image], :imageable => user) if params[:user][:images].present?
      flash[:notice] = "Profile updated."
    else
      flash[:alert] = "You don't have right access."
    end
    redirect_to request.referrer
  end

  def image
    @user = User.find params[:id]
      render :partial => "show_image"
  end

  def block
    user = User.find params[:id]
    BlockedUser.create(:blocked_by => current_user.id, :blocked_to => user.id)
    flash[:notice] = "User #{user.email} has been blocked."
    redirect_to request.referrer
  end
  def unblock
    user = User.find params[:id]
    blocked_user = BlockedUser.where(:blocked_to => params[:id]).first
    blocked_user.destroy if blocked_user.present?
    flash[:notice] = "User #{user.email} has been unblocked."
    redirect_to request.referrer
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :image => [:image, :imageable])
    end
    # def blocked_user_param
    #   params.require(:blocked_user).permit(:)
    # end
    def encrypt_id
      if params[:id].present?
        hashids = Hashids.new("let's e-chat with your friend", 16)
        params[:id] = hashids.decode_hex(params[:id])
      end
    end
end
