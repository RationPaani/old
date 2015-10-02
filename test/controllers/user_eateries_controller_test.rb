require 'test_helper'

class UserEateriesControllerTest < ActionController::TestCase
  setup do
    @user_eatery = user_eateries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_eateries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_eatery" do
    assert_difference('UserEatery.count') do
      post :create, user_eatery: { category: @user_eatery.category, eatery_id: @user_eatery.eatery_id, price: @user_eatery.price, spec1: @user_eatery.spec1, spec2: @user_eatery.spec2, spec3: @user_eatery.spec3, user_id: @user_eatery.user_id }
    end

    assert_redirected_to user_eatery_path(assigns(:user_eatery))
  end

  test "should show user_eatery" do
    get :show, id: @user_eatery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_eatery
    assert_response :success
  end

  test "should update user_eatery" do
    patch :update, id: @user_eatery, user_eatery: { category: @user_eatery.category, eatery_id: @user_eatery.eatery_id, price: @user_eatery.price, spec1: @user_eatery.spec1, spec2: @user_eatery.spec2, spec3: @user_eatery.spec3, user_id: @user_eatery.user_id }
    assert_redirected_to user_eatery_path(assigns(:user_eatery))
  end

  test "should destroy user_eatery" do
    assert_difference('UserEatery.count', -1) do
      delete :destroy, id: @user_eatery
    end

    assert_redirected_to user_eateries_path
  end
end
