class ConversationsController < ApplicationController
  before_filter :encrypt_id
  def create
    user = User.where(:id => params[:user_id]).first
    if user.blank?
      redirect_to root_path
      return
    end
    @conversation = Conversation.get(current_user.id, params[:user_id])
    add_to_conversations unless conversated?
  end

  def close
    @conversation = Conversation.find(params[:id])
 
    session[:conversations].delete(@conversation.id)
 
    respond_to do |format|
      format.js
    end
  end

  private

  def encrypt_id
    if params[:user_id].present?
      hashids = Hashids.new("let's e-chat with your friend", 16)
      params[:user_id] = hashids.decode_hex(params[:user_id])
    end
  end

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end


end
