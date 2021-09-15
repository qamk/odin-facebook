require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(username: 'test', email: 'test@email.com', password: 'Sz5;&G3RpQ')
  end

  test "valid with a username, email and password" do
    assert @user.save, 'Saves with a username and password'
  end

  test "needs an email" do
    @user.email = nil
    refute @user.save, 'It does not save'
    assert_not_nil @user.errors[:email], 'Email is needed'
  end

  test "needs a username" do
    @user.username = nil
    @user.email = 'test@email.com'
    refute @user.save, 'It does not save'
    assert_not_nil @user.errors[:username], 'Username is needed'
  end

end
