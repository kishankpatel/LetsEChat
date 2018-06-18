class GroupsController < ApplicationController
  before_filter :encrypt_group_id, :only => [:show]
  def new
  	@group = Group.new
  end

  def create
  	params[:group][:created_by] = current_user.id
  	group = Group.create(group_params)
  	@user_group = UserGroup.create(:user_id => current_user.id, :group_id => group.id, :added_by => current_user.id, :is_admin => 1)
    image = Image.create(image: params[:group][:images][:image], :imageable => group) if params[:group][:images].present?
  	
    redirect_to root_path
  end

  def show
  	@group = current_user.groups.where(:id => params[:id]).first
  	unless @group.present?
  		redirect_to root_path
      return
  	end
  	@group_message = GroupMessage.new
    user_group = @group.users.where("user_id =?", current_user.id).first
  	@group_messages = @group.group_messages.where("created_at >= '#{user_group.created_at}'")
  end
  def edit
    @group = Group.find_by_id params[:id]
    render partial:"edit"
  end

  def update
    group = Group.find(params[:id])
    group.update_attributes(group_params)
    image = Image.create(image: params[:group][:images][:image], :imageable => group) if params[:group][:images].present?
    flash[:notice] = "Group has been updated."
    redirect_to request.referrer
  end

  def image
    @group = Group.find params[:id]
    render :partial => "show_image"
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :created_by, :image => [:image, :imageable])
  end
end
