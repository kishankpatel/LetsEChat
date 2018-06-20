class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if user_signed_in?
	    @groups = current_user.groups                                 
	    session[:conversations] ||= []
	 
	    @users = current_user.conversations.map{|c| c.opposed_user(current_user)}
	    @conversations = Conversation.includes(:recipient, :messages)
	                                 .find(session[:conversations])
	end	                            
  end
end
