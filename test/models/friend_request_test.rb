require "test_helper"

class FriendRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user1 = User.create(username: 'test1', email: 'test1@email.com', password: 'Sz5;&G3RpQ')
    @user2 = User.create(username: 'test2', email: 'test2@email.com', password: 'Sz{;&g9rpQ')
  end

  test "allows only one active request at a time" do
    first_fr = @user1.sent_requests.build(receiver: @user2)
    second_fr = @user1.sent_requests.build(receiver: @user2)
    assert first_fr.save, 'Saves the first request'
    refute second_fr.save, 'Does not save the second request'
  end

  test "a request recipient cannot send the sender a request before responding" do
    first_fr = @user1.sent_requests.build(receiver: @user2)
    repeat_fr = @user2.sent_requests.build(receiver: @user1)
    assert first_fr.save, 'Saves the first request'
    refute repeat_fr.save, 'Does not save the second request'
  end

end
