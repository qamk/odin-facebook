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

  test "username must be between 2..50 characters" do
    valid_username = '2GBjXkA17Efzhh1sDqHH'
    too_long_username = valid_username * 3
    too_short_username = '2'
    email = 'test@email.com'
    password = 'Sz5;&G3RpQ'
    valid_user = User.new(username: valid_username, email: email, password: password)
    too_long_user = User.new(username: too_long_username, email: email, password: password)
    too_short_user = User.new(username: too_short_username, email: email, password: password)
    assert valid_user.save, 'Saves a user with a valid username length'
    refute too_long_user.save, 'Does not save a user with a username that is too long'
    refute too_short_user.save, 'Does not save a user with a username that is too short'
  end

  test "bio cannot exceed 275 characters" do
    valid_bio = 'Hi this is a test bio. This is not a real bio '
    invalid_bio = valid_bio * 6
    assert @user.update(bio: valid_bio), 'Saves a user with valid bio length'
    refute @user.update(bio: invalid_bio), 'Does not save a user with an invalid bio length'
  end

  test "no duplicate emails" do
    username = 'MyNameIsValid'
    email = 'test@email.com'
    password = 'thisisaSECUREpassword1'
    valid_user = User.new(username: username, email: email, password: password)
    valid_user_duplicate = User.new(username: username, email: email, password: password)
    assert valid_user.save, 'Saves a user with a valid email'
    refute valid_user_duplicate.save, 'Does not save a valid user with an email that was already used'
  end

  test "email must be formatted (more or less) correctly" do
    username = 'MyNameIsCool'
    password = 'THISisANOTHERsecurePASSword'
    valid_email = 'valid@email.com'
    invalid_email = 'invalidatemaildotcom'
    invalid_email_spaces = 'invalid @email.com'
    valid_user = User.new(username: username, email: valid_email, password: password)
    invalid_user = User.new(username: username, email: invalid_email, password: password)
    invalid_user_spaces = User.new(username: username, email: invalid_email_spaces, password: password)
    assert valid_user.valid?, 'Saves a user with a valid email format'
    refute invalid_user.valid?, 'Does not save a user with an incorrect email format'
    refute invalid_user_spaces.valid?, 'Does not save a user with a valid email format... but with spaces (invalid)'
  end

end
