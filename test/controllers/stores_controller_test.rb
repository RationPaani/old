require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  setup do
    @store = stores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post :create, store: { add1: @store.add1, add2: @store.add2, city: @store.city, enable: @store.enable, state: @store.state, store_detail: @store.store_detail, store_image: @store.store_image, store_name: @store.store_name, store_offer: @store.store_offer, store_type: @store.store_type, subs_status: @store.subs_status, zip: @store.zip }
    end

    assert_redirected_to store_path(assigns(:store))
  end

  test "should show store" do
    get :show, id: @store
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @store
    assert_response :success
  end

  test "should update store" do
    patch :update, id: @store, store: { add1: @store.add1, add2: @store.add2, city: @store.city, enable: @store.enable, state: @store.state, store_detail: @store.store_detail, store_image: @store.store_image, store_name: @store.store_name, store_offer: @store.store_offer, store_type: @store.store_type, subs_status: @store.subs_status, zip: @store.zip }
    assert_redirected_to store_path(assigns(:store))
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete :destroy, id: @store
    end

    assert_redirected_to stores_path
  end
end
