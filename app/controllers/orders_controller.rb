class OrdersController < ApplicationController
  before_action :set_order, only: [:sdelete, :show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
  storeid = User.find(current_user).stores
    @orders = Order.all.where(store: storeid, svis: true)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end


  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def sdelete
    @order.update(svis: false)
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order, :buyer_id, :user_id, :product_id, :quantity, :logistic_id, :bresponse, :sresponse, :lresponse, :bvis, :svis, :lvis)
    end
end
