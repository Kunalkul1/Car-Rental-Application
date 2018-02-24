require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "user1", email: "user1@test.com", password: "password1", admin: false, super_admin: false)
  end

  test "user should be valid" do
    assert @user.valid?, message = "user not valid"
  end

  test "name should be present" do
    @user.name = nil
    assert_not @user.valid?, message = "user cannot be saved without name"
  end

  test "email should be present" do
    @user.email = nil
    assert_not @user.valid?, message = "user cannot be saved without email"
  end

  test "password should be present" do
    @user.encrypted_password = nil
    assert_not @user.valid?, message = "user cannot be saved without password"
  end

  test "password should be of at least 6 char long" do
    @user.encrypted_password = "12345"
    assert_not @user.valid?, message = "password lenght cannot be less than 6"
  end

  test "email should be unique" do
    @user2 = User.new(email: "duplicateuser@test.com", name: "dup2", password: "password2")
    @user2.save!
    new_user = @user2.dup
    assert_not new_user.valid?, message = "users cannot have duplicate email addresses"
  end

end
