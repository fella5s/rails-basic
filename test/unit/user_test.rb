require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  setup do
    @user = users(:user)
  end

  test "a user with all attributes should be valid" do
    assert @user.valid?
  end
  
  test "a user without a email should not be valid" do
    @user.email = ''
    assert @user.invalid?
  end
  
  test "user email must be unique" do
    other_user = @user.dup
    assert other_user.invalid?
  end
  
end
