require 'test_helper'

class StoreProductsControllerTest < ActionController::TestCase
  setup do
    @store_product = store_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:store_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store_product" do
    assert_difference('StoreProduct.count') do
      post :create, store_product: { in_r: @store_product.in_r, in_w: @store_product.in_w, price: @store_product.price, product_id: @store_product.product_id, stock: @store_product.stock, user_id: @store_product.user_id }
    end

    assert_redirected_to store_product_path(assigns(:store_product))
  end

  test "should show store_product" do
    get :show, id: @store_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @store_product
    assert_response :success
  end

  test "should update store_product" do
    patch :update, id: @store_product, store_product: { in_r: @store_product.in_r, in_w: @store_product.in_w, price: @store_product.price, product_id: @store_product.product_id, stock: @store_product.stock, user_id: @store_product.user_id }
    assert_redirected_to store_product_path(assigns(:store_product))
  end

  test "should destroy store_product" do
    assert_difference('StoreProduct.count', -1) do
      delete :destroy, id: @store_product
    end

    assert_redirected_to store_products_path
  end
end
