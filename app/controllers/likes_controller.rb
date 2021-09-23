class LikesController < ApplicationController

  # def create
  #   @new_like = Like.new(like_params)
  #   if @new_like.save
  #     redirect_to :back, notice: 'like sent'
  #   else
  #     flash[:error] = 'Failed to send like'
  #     redirect_to :back
  #   end
  # end

  # def destroy
  #   @like = Like.find_by(params[:like])
  #   if @like.destroy
  #     redirect_to :back, notice: 'Removed like'
  #   else
  #     flash[:error] = 'Failed to remove like'
  #     redirect_to :back
  #   end
  # end

  def like_unlike_toggle
    @like = Like.find_by(like_params)
    @like&.destroy || Like.create(like_params)
    redirect_back fallback_location: '/', allow_other_hosts: false
  end

  private

  def like_params
    params.require(:like).permit(:likeable_type, :likeable_id, :user_id)
  end
end
