require 'test_helper'

class ReservationsControllerTest < ActionController::TestCase
  
  setup do
    @book          = books(:steppenwolf)
    @reserved_book = books(:rails_recipes)
    @reservation   = Reservation.create(book: @reserved_book, email: 'library@eficode.com')
  end
  
  test "new reservation" do
    user = users(:user)
    session[:user_id] = user.id
    get :new, book_id: @book.id
    assert_response :success
    assert_equal @book, assigns(:book)
    assert assigns(:reservation)
    assert assigns(:reservation).new_record?
  end
  
  test "create reservation with valid parameters" do
    user = users(:user)
    session[:user_id] = user.id
    assert_difference("Reservation.count", +1) do
      post :create, book_id: @book.id, reservation: {email: 'library@eficode.com'}
      assert_response :redirect
      assert_redirected_to book_path(@book)
      assert flash[:notice]
    end
  end

  test "create reservation with invalid parameters" do
    user = users(:user)
    session[:user_id] = user.id
    post :create, book_id: @book.id, reservation: {email: 'invalid'}
    assert_response :success
    assert assigns(:reservation)
    assert assigns(:reservation).new_record?
    assert_template :new
  end
  
  test "Admin can free reservation" do
    user = users(:admin)
    session[:user_id] = user.id
    put :free, book_id: @reserved_book.id, id: @reservation.id
    assert_response :redirect
    assert_redirected_to book_path(@reserved_book)
    assert_equal 'free', assigns(:reservation).state
    assert flash[:notice]
  end
  
   test "User can free reservation" do
    user = users(:user)
    session[:user_id] = user.id
    put :free, book_id: @reserved_book.id, id: @reservation.id
    assert_response :redirect
    assert_redirected_to book_path(@reserved_book)
    assert_equal 'free', assigns(:reservation).state
    assert flash[:notice]
  end

end
