class LikesController < ApplicationController

  # 
  def create
    @new_like = Like.new(like_params)
    if @new_like.save
      redirect_to :back, notice: 'like sent'
    else
      flash[:error] = 'Failed to send like'
      redirect_to :back
    end
  end

  def destroy
    @like = Like.find_by(params[:like])
    if @like.destroy
      redirect_to :back, notice: 'Removed like'
    else
      flash[:error] = 'Failed to remove like'
      redirect_to :back
    end
  end

  private

  def like_params
    params.permit(:likeable_type, :likeable_id, :user)
  end
end
