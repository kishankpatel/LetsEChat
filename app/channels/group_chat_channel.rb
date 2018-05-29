class GroupChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group_chat"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def conversation data
  	p "---conversation-----------"
  	p data
  	p "---conversation-----------"
  	p "in conversation channel method"
  	user_email = User.find(data['sender_id']).email
    ActionCable.server.broadcast "group_chat", message: data['message'], group_id: data['group_id'], sender_id: data['sender_id'], email: user_email
  end
end
