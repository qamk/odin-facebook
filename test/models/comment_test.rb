require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

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

end
