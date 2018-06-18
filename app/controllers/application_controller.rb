class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception


  private

  def encrypt_id
    if params[:user_id].present?
      hashids = Hashids.new("let's e-chat with your friend", 16)
      params[:user_id] = hashids.decode_hex(params[:user_id])
    end
    if params[:id].present?
      hashids = Hashids.new("let's e-chat with your friend", 16)
      params[:id] = hashids.decode_hex(params[:id])
    end
  end
  def encrypt_group_id
    if params[:group_id].present?
      hashids = Hashids.new("let's e-chat with group", 16)
      params[:user_id] = hashids.decode_hex(params[:user_id])
    end
    if params[:id].present?
      hashids = Hashids.new("let's e-chat with group", 16)
      params[:id] = hashids.decode_hex(params[:id])
    end
  end
  
end
