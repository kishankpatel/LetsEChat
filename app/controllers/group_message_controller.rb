class GroupMessageController < ApplicationController
  def create
    params[:group_message][:user_id] = current_user.id
    p params[:group_message]
    if current_user.groups.where(:id => params[:group_message][:group_id]).present?
      @group_message = GroupMessage.create(group_message_params)
      respond_to do |format|
        format.js
      end
    else
      render text:"Group not found"
    end
  end
  
  private

  def group_message_params
    params.require(:group_message).permit(:body, :user_id, :group_id)
  end
end