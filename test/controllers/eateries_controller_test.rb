require 'test_helper'

class EateriesControllerTest < ActionController::TestCase
  setup do
    @eatery = eateries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eateries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eatery" do
    assert_difference('Eatery.count') do
      post :create, eatery: { image: @eatery.image, name: @eatery.name, size: @eatery.size }
    end

    assert_redirected_to eatery_path(assigns(:eatery))
  end

  test "should show eatery" do
    get :show, id: @eatery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eatery
    assert_response :success
  end

  test "should update eatery" do
    patch :update, id: @eatery, eatery: { image: @eatery.image, name: @eatery.name, size: @eatery.size }
    assert_redirected_to eatery_path(assigns(:eatery))
  end

  test "should destroy eatery" do
    assert_difference('Eatery.count', -1) do
      delete :destroy, id: @eatery
    end

    assert_redirected_to eateries_path
  end
end
