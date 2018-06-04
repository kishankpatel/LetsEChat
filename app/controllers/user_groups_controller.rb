class UserGroupsController < ApplicationController
  
  def create
    group = current_user.groups.where(:id => params[:user_group][:group_id]).first
    user = User.find_by_id params[:user_group][:user_id]
    # checking the group is exist or not on the behalf of current user & checking the user is an admin or not
    if group.present? 
      # if group.user_groups.where(:user_id => current_user.id).present? && group.user_groups.where(:user_id => current_user.id).first.is_admin
      #   flash[:alert] = "You do not have admin access."
      #   redirect_to request.referrer
      #   return
      # end
      if group.user_groups.where(:user_id => params[:user_group][:user_id]).present?
        flash[:alert] = "User already added in the group"
        redirect_to request.referrer
      else
        user_group = UserGroup.create(user_groups_params)
        user_group.update_attribute :added_by, current_user.id
        flash[:notice] = "User #{user.email} added to the group."
        redirect_to request.referrer
      end
    else
      flash[:alert] = "Group not found"
      redirect_to request.referrer
    end
  end

  def my_contacts
    render :json => User.all
  end

  private

  def user_groups_params
    params.require(:user_group).permit(:user_id, :group_id)
  end
end