require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "needs a body" do
    user = User.create(username: 'test', email: 'test@email.com', password: 'Sz5;&G3RpQ')
    post = Post.new(user: user)
    refute post.save, 'Needs a body to save'
    assert_not_nil post.errors[:body], 'Has errors in the body'
  end

  test "belongs to a user" do
    post = posts(:first_post)
    user = users(:first)
    assert_equal post.user, user, 'Post belongs to a user'
  end

  test "can have comments" do
    post = posts(:first_post)
    comment = comments(:first_comment)
    assert_equal comment.post, post, 'Comment is on a post'
  end

  test "owner can comment" do
    owner = users(:first)
    post = posts(:first_post)
    comment = comments(:second_comment)
    assert_equal post, comment.post, 'Comment is on the post'
    assert_equal owner, comment.commenter, 'Comment belongs to post owner'
    assert_equal owner, post.user, 'Post and comment owner are the same'
  end

  test "can be liked by a user" do
    liked_by_likes = users(:second).likes
    post_likes = posts(:first_post).likes
    assert_includes post_likes.take(2), liked_by_likes.take, 'Is liked by the correct user'
  end

  test "post body cannot be more than 500 characters" do
    user = User.create(username: 'test', email: 'test@email.com', password: 'Sz5;&G3RpQ')
    valid_post_body = 'lorem ipsum or something '
    invalid_post_body = valid_post_body * 21
    valid_post = Post.new(body: valid_post_body, user: user)
    invalid_post = Post.new(body: invalid_post_body, user: user)
    assert valid_post.save, 'Saves a post with a body under 500 characters'
    refute invalid_post.save, 'Does not save a post with a body over 500 characters'
  end

end
