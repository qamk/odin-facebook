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
    assert_equal comment.post, post, 'Comment is on the post'
    assert_equal comment.commenter, owner, 'Comment belongs to post owner'
    assert_equal post.user, owner, 'Post and comment owner are the same'
  end

  test "can be liked" do

  end

end
