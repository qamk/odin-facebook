class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :grab_user, except: %i[show]

  TIMELINE_POSTS_PER_PAGE = 8
  FEED_POSTS_PER_PAGE = 16
  MINI_FRIENDS_LIST = 6

  # GET /feed (root)
  def feed
    @page = params.fetch(:page, 0).to_i
    friends = find_user_friend_ids(current_user) << current_user.id
    @feed_posts = Post.where(user: friends).for_page(@page, FEED_POSTS_PER_PAGE).includes(:likes, :user)
    @upcoming_posts = Post.where(user: friends).for_page(@page + 1, FEED_POSTS_PER_PAGE)
  end
  
  # GET /users/:id
  def show
    @user = User.find(params[:id])
    timeline
    render :timeline
  end

  # GET /timeline
  def timeline
    grab_mini_friends_list
    grab_post_info
    grab_who_to_add
  end

  # GET /timeline/edit
  def edit
    timeline
    render :timeline
  end

  # PUT or PATCH /timeline
  def update
    if @user.update(update_params)
      redirect_to timeline_path, notice: 'Successfully updated timeline'
    else
      flash.now[:error] = 'Failed to update timeline. Please check error messages.'
      render 'timeline'
    end
  end

  # GET /notifications
  def notifications
  end

  private

  def grab_user
    @user = current_user
  end

  def find_user_friend_ids(user)
    Friend.friends_of(user).pluck(:main_user_id, :friend_id).flatten - [user.id]
  end

  def grab_mini_friends_list
    friends_list_ids = find_user_friend_ids(current_user)
    @friends_list = User.list_users_in_id_collection(friends_list_ids)
  end

  def grab_who_to_add
    friends_and_self = find_user_friend_ids(current_user) << current_user.id
    @who_to_add = User.where.not(id: friends_and_self)
  end

  def grab_post_info
    @page = params.fetch(:page, 0).to_i
    @posts = @user.posts.for_page(@page, TIMELINE_POSTS_PER_PAGE).includes(:user)
    @upcoming_posts = @user.posts.for_page(@page + 1, TIMELINE_POSTS_PER_PAGE)
  end

  def update_params
    params.require(:user).permit(:bio)
  end
end
