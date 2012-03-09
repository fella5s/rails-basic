require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "create user with valid parameters" do
    post :create, user: {email: 'user@mail.com', password: 'password', password_confirmation: 'password'}
    assert_response :redirect
    assert_redirected_to root_url
    assert flash[:notice] 
  end
  
  test "create user with invalid parameters" do
    post :create, user: {email: 'email'}
    assert_response :success
    assert assigns(:user)
    assert assigns(:user).new_record?
    assert_template :new
  end
  
  test "admin can destroy user" do
    user = users(:admin)
    user2 = users(:user2)
    session[:user_id] = user.id
    assert_difference("User.count", -1) do
      delete :destroy, id: user2.id
      assert_response :redirect
      assert_redirected_to users_path
      assert flash[:notice]
    end
  end
  
  test "Updating user - new password" do
    user = users(:user)
    session[:user_id] = user.id
    put :update, id: user.id,
                 user: {password: 'newpwd',
                        password_confirmation: 'newpwd'}
                     
    assert_response :redirect
    assert_redirected_to root_url
    assert flash[:notice] 
  end

end
