class UsersController < ApplicationController
  before_filter :encrypt_id, :only => [:show, :block, :unblock]
  def my_contacts
    @users = current_user.conversations.map{|c| c.opposed_user(current_user) if( c.opposed_user(current_user).email.downcase.include?(params[:query].downcase) || c.opposed_user(current_user).full_name.downcase.include?(params[:query].downcase) )}[0..5]
    render :json => @users
  end
  def get_users
    if params[:query].present?
      @users = User.all.where("(LOWER(email) like :search_query OR LOWER(first_name) like :search_query OR LOWER(last_name) like :search_query) AND id != '#{current_user.id}'", search_query: "%#{params[:query].downcase}%").limit(10)
      render :partial => "show_user_list"
    else
      render :text => "blank_search"
    end
  end
  def show
    if params[:id].present?
      @user = User.find params[:id]
      if @user.blocked_users.where(:blocked_to => current_user.id).present?
        flash[:alert] = "#{@user.email} has been blocked you."
        redirect_to request.referrer
        return
      end
    else
      @user = current_user
    end
  end
  def edit
    @user = User.find params[:id]
    render partial:"edit"
  end
  def update
    if params[:id] == current_user.id.to_s
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
