require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "needs an email" do
    user = User.new(username: 'name1')
    refute user.save, 'It does not save'
    assert_not_nil user.errors[:email], 'Email is needed'
  end

end
