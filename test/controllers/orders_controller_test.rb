require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { bresponse: @order.bresponse, buyer_id: @order.buyer_id, bvis: @order.bvis, logistic_id: @order.logistic_id, lresponse: @order.lresponse, lvis: @order.lvis, order: @order.order, product_id: @order.product_id, quantity: @order.quantity, sresponse: @order.sresponse, svis: @order.svis, user_id: @order.user_id }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { bresponse: @order.bresponse, buyer_id: @order.buyer_id, bvis: @order.bvis, logistic_id: @order.logistic_id, lresponse: @order.lresponse, lvis: @order.lvis, order: @order.order, product_id: @order.product_id, quantity: @order.quantity, sresponse: @order.sresponse, svis: @order.svis, user_id: @order.user_id }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
