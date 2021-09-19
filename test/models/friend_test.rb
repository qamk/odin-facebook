require "test_helper"

class FriendTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user1 = User.create(username: 'test1', email: 'test1@email.com', password: 'Sz5;&G3RpQ')
    @user2 = User.create(username: 'test2', email: 'test2@email.com', password: 'Sz5;&8mB[zZx.')
  end

  test "cannot be friends without responding to a friend request" do
    new_friend = Friend.new(main_user: @user1, friend: @user2)
    refute new_friend.save, 'Does not save a new friendship without a request'
  end

  test "made when a friend request is accepted" do
    @user1.sent_requests.build(receiver: @user2).save
    friend_request = @user1.sent_requests.first
    friend_request.update(accepted: true)
    assert_not_empty @user2.accepted_requests, 'User 2 has a friend'
    assert_equal @user1.friends, @user2.accepted_requests, 'User 2\'s friend is User 1!'
  end

  test "cannot have duplicate records" do
    friend_request = FriendRequest.create(sender: @user1, receiver: @user2)
    friendship = Friend.new(main_user: @user1, friend: @user2)
    friendship_duplicate = Friend.new(main_user: @user1, friend: @user2)
    friendship_duplicate2 = Friend.new(main_user: @user2, friend: @user1)
    assert friendship.save, 'Adds a new friend(ship)'
    refute friendship_duplicate.save, 'Does not save a duplicate friend(ship)'
    refute friendship_duplicate2.save, 'Does not save a duplicate friend(ship) regardless of main_user and friend order'
  end
end
