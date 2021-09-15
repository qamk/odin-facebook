require "test_helper"

class LikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # def setup
  #   @user = User.new(name: 'test_user', email: 'test@email.com')
  # end

  test "does not save without a user" do
    like_comment = Like.new(user_id: nil, likeable_type: 'Comment', likeable_id: 1)
    like_post = Like.new(user_id: nil, likeable_type: 'Post', likeable_id: 1)

    refute like_comment.save, 'Needs a user to like a comment'
    refute like_post.save, 'Needs a user to like a post'
  end

  test "same comment cannot be liked twice by the same user" do
    first_like = Like.new(user_id: 1, likeable_type: 'Comment', likeable_id: 1)
    second_like = Like.new(user_id: 1, likeable_type: 'Comment', likeable_id: 1)
    assert first_like.save, 'Saves the first like'
    refute second_like.save, 'Does not save the second like'
  end

  test "same post cannot be liked twice by the same user" do
    first_like = Like.new(user_id: 1, likeable_type: 'Post', likeable_id: 1)
    second_like = Like.new(user_id: 1, likeable_type: 'Post', likeable_id: 1)
    assert first_like.save, 'Saves the first like'
    refute second_like.save, 'Does not save the second like'
  end
end
