class TempImageController < ApplicationController
    skip_before_action :verify_authenticity_token  
    def create
      @temp_image = TempImage.create(image: params[:temp_image][:image], :user_id => current_user.id)
      render :partial => "show"
    end

    private
    def temp_image_params
        params.require(:temp_image).permit(:image)
    end
end
