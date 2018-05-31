class GroupsController < ApplicationController
  def new
  	@group = Group.new
  end

  def create
  	params[:group][:created_by] = current_user.id
  	group = Group.create(group_params)
  	@user_group = UserGroup.create(:user_id => current_user.id, :group_id => group.id, :added_by => current_user.id, :is_admin => 1)
    image = Image.create(image: params[:group][:images][:image], :imageable => group)
  	
    redirect_to root_path
  end

  def show
  	@group = Group.find_by_id params[:id]
  	unless @group.present?
  		redirect_to root_path
  	end
  	@group_message = GroupMessage.new
  	@group_messages = @group.group_messages
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

  private

  def group_params
    params.require(:group).permit(:name, :description, :created_by, :image => [:image, :imageable])
  end
end
