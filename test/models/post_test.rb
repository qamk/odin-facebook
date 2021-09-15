require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "needs a body" do
    post = Post.new
    refute post.save, 'Has no body'
    assert_not_nil post.errors[:body], 'Has errors in the body'
  end

  test "belongs to a user" do
    post = posts(:first_post)
    user = users(:first)
    assert post.belongs_to user, 'Post belongs to a user'
  end

  test "can have comments" do
    post = posts(:first_post)
    comment = comments(:first_comment)
    assert comment.belongs_to post, 'Comment is on a post'
  end

  test "owner can comment" do
    owner = users(:first)
    post = posts(:first_posts)
    comment = comments(:second_comment)
    assert comment.belongs_to post, 'Comment is on the post'
    assert comment.belongs_to owner, 'Comment belongs to post owner'
    assert post.belongs_to owner, 'Post and comment owner are the same'
  end
end
