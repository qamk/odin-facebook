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
    friend_list_objs = Friend.friends_list_paginated(current_user, @page, FRIENDS_PER_PAGE)
    users = grab_user_objects_from(friend_list_objs)
    @friends_list = friend_list_objs.zip(users)
  end

  private

  def grab_user_objects_from(collection)
    user_objs = collection.map(&:main_user).concat(collection.map(&:friend))
    user_obj_ids = user_objs.map(&:id)
    query_user_ids(user_obj_ids)
  end

  def friends_params
    params.permit(:page)
  end

end
