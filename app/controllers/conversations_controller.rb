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

  def accept
    conversation = Conversation.find(params[:id])
    conversation.update_attribute :is_accepted, true
    redirect_to request.referrer
  end

  private


  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end


end
