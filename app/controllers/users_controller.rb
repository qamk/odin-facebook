class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :grab_user
  before_action :paginate, except: %i[update]

  TIMELINE_POSTS_PER_PAGE = 8
  FEED_POSTS_PER_PAGE = 16
  USER_INDEX_PER_PAGE = 30
  MINI_FRIENDS_LIST = 6

  # GET /feed (root)
  def feed
    grab_who_to_add
    friends = find_user_friend_ids(current_user) << current_user.id
    @feed_posts = Post.where(user: friends).for_page(@page, FEED_POSTS_PER_PAGE).includes(:likes, :user)
    @upcoming_posts = Post.where(user: friends).for_page(@page + 1, FEED_POSTS_PER_PAGE)
  end

  # GET /users
  def index
    @users = \
      User.search(params[:query]).for_page(@page, USER_INDEX_PER_PAGE).except_user(@user).includes(:friends)
    grab_mini_friends_list
    @requests = grab_pending_friend_requests
  end

  # GET /users/:id/timeline
  def show
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
    valid_upload = valid_file_data?
    if valid_upload && @user.update(update_params)
      redirect_to timeline_path, notice: 'Successfully updated timeline'
    else
      flash.now[:error] = 'Failed to update timeline. Please check error messages.'
      timeline
      render :timeline
    end
  end

  private

  def grab_user
    @user = User.find_by(id: params[:id]) || current_user
  end

  def paginate
    @page = params.fetch(:page, 0).to_i
  end

  def valid_file_data?
    file = params[:user][:avatar]
    return true unless file

    valid_types = %w[image/png image/jpeg]
    hash = { file: file, valid_types: valid_types }
    UploaderCheckerService.validate(hash)
  end

  def find_user_friend_ids(user = @user)
    Friend.friends_of(user).pluck(:main_user_id, :friend_id).flatten - [user.id]
  end

  # Returns a 'User' collection containing active friend requests for @user
  def grab_pending_friend_requests
    requests_list_ids = FriendRequest.open_requests(current_user.id).pluck(:sender_id, :receiver_id).flatten
    query_user_ids(requests_list_ids)
  end

  # Returns a 'User' collection containing friends of @user
  def grab_mini_friends_list
    friends_list_ids = find_user_friend_ids
    @friends_list = query_user_ids(friends_list_ids)
  end

  def grab_who_to_add
    friends_and_self = find_user_friend_ids(current_user) << current_user.id
    requested = grab_pending_friend_requests
    users_to_avoid = friends_and_self.concat(requested)
    @who_to_add = User.where.not(id: users_to_avoid)
  end

  def grab_post_info
    @page = params.fetch(:page, 0).to_i
    @posts = @user.posts.for_page(@page, TIMELINE_POSTS_PER_PAGE).includes(:user)
    @upcoming_posts = @user.posts.for_page(@page + 1, TIMELINE_POSTS_PER_PAGE)
  end

  def update_params
    params.require(:user).permit(:bio, :avatar)
  end

  def search_params
    params.permit(:query)
  end
end
