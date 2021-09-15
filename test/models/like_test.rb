require "test_helper"

class LikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.create(username: 'test', email: 'test@email.com', password: 'Sz5;&G3RpQ')
    @post = @user.posts.build(body: 'Test Post')
    @comment = @user.comments.build(body: 'Test comment', post: @post)
  end

  test "does not save without a user" do
    like_comment = @comment.likes.build(user: nil)
    like_post = @post.likes.build(user: nil)

    refute like_comment.save, 'Needs a user to like a comment'
    refute like_post.save, 'Needs a user to like a post'
  end

  test "same comment cannot be liked twice by the same user" do
    first_like = @comment.likes.build(user: @user)
    second_like = @comment.likes.build(user: @user)
    assert first_like.save, 'Saves the first like'
    refute second_like.save, 'Does not save the second like'
  end

  test "same post cannot be liked twice by the same user" do
    first_like = @post.likes.build(user: @user)
    second_like = @post.likes.build(user: @user)
    assert first_like.save, 'Saves the first like'
    refute second_like.save, 'Does not save the second like'
  end
end
