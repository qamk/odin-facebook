class FriendsController < ApplicationController

  FRIENDS_PER_PAGE = 10

  # DELETE friends/:id
  def destroy
    @friendship = Friend.find(params[:id])
    if @friendship.destroy
      redirect_to root_path, notice: 'Friend removed'
    else
      flash[:error] = 'Failed to remove friend'
      redirect_to root_path
    end
  end

  def friends_list
    @page = params.fetch(:page, 0).to_i
    @friends_list = Friend.includes(:users).friends_list(current_user, @page, FRIENDS_PER_PAGE)
  end

  private

  def friends_params
    params.permit(:page)
  end

end
