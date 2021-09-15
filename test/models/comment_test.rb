require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "needs a body" do
    user = User.create(username: 'test', email: 'test@email.com', encrypted_password: 'Sz5;&G3RpQ')
    post = Post.create(user: user, body: 'This is a test post')
    comment = Comment.new(body: nil, commenter: user, post: post)
    refute comment.save, 'Needs a body to save'
  end

  test "must belong to a user" do
    comment = comments(:third_comment)
    refute comment.save, 'Does not save comment'
    assert_not_nil comment.errors[:commenter], 'Needs a commenter'
  end

  test "must belong to a post" do
    comment = comments(:fourth_comment)
    refute comment.save, 'Does not save comment'
    assert_not_nil comment.errors[:post], 'Needs a post'
  end

  test "can be liked" do
    comment = comments(:second_comment)
    first_like = likes(:first_comment_like)
    second_like = likes(:second_comment_like)
    assert_includes comment.likes, first_like, 'Comment liked by another user'
    assert_includes comment.likes, second_like, 'Self-like on a comment'
  end

end
