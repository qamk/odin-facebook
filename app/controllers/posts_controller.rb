class PostsController < ApplicationController
  before_action :grab_post, except: %i[create]
  before_action :owner?, except: %i[show create]

  def show
    @comments = @post.comments.includes(:likes)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Successfully updated post'
    else
      flash.now[:error] = 'Failed to update post. Please check errors'
      render :edit
    end
  end

  def create
    @new_post = current_user.posts.build(post_params)
    if @new_post.save
      redirect_to post_path(@new_post), notice: 'Successfully created post'
    else
      flash[:error] = 'Failed to create new post'
      redirect_to root_path
    end
  end

  def destroy
    # redirect_to root_path unless is_owner?
    if @post.destroy
      redirect_to root_path, notice: 'Successfully deleted post'
    else
      flash[:error] = 'Failed to delete post'
      redirect_to root_path
    end
  end

  private

  def owner?
    @post.user == current_user
  end

  def grab_post
    @post = params[:id]
  end

  def post_params
    params.require(:post).permit(:body)
  end

end
