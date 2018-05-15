class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak data
  	p "in speak method"
  	ActionCable.server.broadcast "room_channel", message: data['message'], conversation_id: data['conversation_id'], recipient_id: data['recipient_id'], sender_id: data['sender_id']
  	p data
  end
end
