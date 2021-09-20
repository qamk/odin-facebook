class UsersController < ApplicationController
  before_action :grab_user, except: %i[show]

  TIMELINE_POSTS_PER_PAGE = 8

  # GET /feed (root)
  def feed
    friends = Friend.friends_of(current_user).includes(:main_user, :friend).disctinct.pluck(:username)
    @feed_posts = Post.where(user: friends).includes(:likes, :users)
  end
  
  # GET /users/:id
  def show
    @user = User.find(params[:id]).includes(:posts)
  end

  # GET /timeline
  def timeline
    @page = params.fetch(:page, 0).to_i
    @posts = @user.posts.for_page(@page, TIMELINE_POSTS_PER_PAGE)
  end

  # GET /timeline/edit
  def edit
  end

  # PUT or PATCH /timeline
  def update
    if @user.update(update_params)
      redirect timeline_path, notice: 'Successfully updated timeline'
    else
      flash.now[:error] = 'Failed to updat timeline. Please check error messages.'
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

  def update_params
    params.require(:user).permit(:bio)
  end
end
