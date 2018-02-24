require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:three)
    login_as @user
  end

  test "should show member" do
    get member_url(@user)
    assert_response :success
  end

  test "should get index" do
    get members_url
    assert_response :success
  end

  test "should get new" do
    get new_member_url
    assert_response :success
  end

  test "should create member" do
    assert_difference('User.count') do
      post members_url, params: { user: { name: "Test User", email: "test_user@test.com", password: "password1"  } }
    end
    assert_redirected_to root_path(User.last)
  end

  # test "should update member" do
  #   patch member_url(@user), params: { user: { name: "updated" } }
  #   assert_redirected_to member_path(@user)
  # end

  test "should destroy member" do
    assert_difference('User.count', -1) do
      delete member_url @user
    end
    assert_redirected_to root_path
  end
end
