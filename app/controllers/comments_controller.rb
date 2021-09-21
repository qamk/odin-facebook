class CommentsController < ApplicationController
  before_action :grab_post
  before_action :grab_comment, except: %i[create]

  # GET /post/:post_id/comments/:id
  def edit
  end

  # POST /post/:post_id/comments
  def create
    @new_comment = Comment.new(comment_params)
    if @new_comment.save
      redirect_to post_path(@post), notice: 'New comment added'
    else
      flash.now[:error] = 'Failed to create comment'
      render 'posts/show'
    end
  end

  # PUT or PATCH post/:post_id/comments/:id
  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: 'Comment updated'
    else
      flash.now[:error] = 'Failed to update comment'
      render 'posts/show'
    end
  end

  # DELETE post/:post_id/comment/:id
  def destroy
    redirect_to :back unless authorized_user?
    if @comment.destroy
      redirect_to post_path(@post), notice: 'Successfully deleted comment'
    else
      flash[:error] = 'Failed to delete post'
      redirect_to root_path
    end
  end

  private

  def authorized_user?
    (current_user == comment.user) #|| (current_user == post.user)
  end

  def grab_post
    @post = Post.find(params[:post_id])
  end

  def grab_comment
    @comment = Comment.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commenter_id, :post_id)
  end

end
