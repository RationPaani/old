class StoreProductsController < ApplicationController
  before_action :set_store_product, only: [:show, :edit, :update, :destroy]

  # GET /store_products
  # GET /store_products.json
  def index
    @store_products = StoreProduct.all
  end

  # GET /store_products/1
  # GET /store_products/1.json
  def show
  end

  # GET /store_products/new
  def new
  @item = Store.find(params[:id]).products
  @product = Product.where.not(id: @item)
  if(Store.find(params[:id]).storetype == 'retail' || Store.find(params[:id]).storetype == 'wholesale')
  @products = @product.where(typ: "retail").text_search(params[:query]).page(params[:page]).per_page(36)
  else if(Store.find(params[:id]).storetype == 'eatery')
  @products = @product.where(typ: "eatery").text_search(params[:query]).page(params[:page]).per_page(36)
  else if(Store.find(params[:id]).storetype == 'logistics')
  @products = @product.where(typ: "vehcle").text_search(params[:query]).page(params[:page]).per_page(36)
    end
   end
  end
  @store_product = StoreProduct.new
  end

  # GET /store_products/1/edit
  def edit
  end

  # POST /store_products
  # POST /store_products.json
  def create
 params[:item_checked].each_with_index do |item_check, index|
    @items = StoreProduct.new
    @items.product_id = params[:item_checked].values[index] # work arround with array(.keys .values)
    @items.store_id = params[:id]
    @items.price = @items.product.price
    @items.stock = 100
    @items.save
    end
    redirect_to new_store_product_path(params[:id])
end

  # PATCH/PUT /store_products/1
  # PATCH/PUT /store_products/1.json
  def update
    respond_to do |format|
      if @store_product.update(store_product_params)
        format.html { redirect_to @store_product, notice: 'Store product was successfully updated.' }
        format.json { render :show, status: :ok, location: @store_product }
      else
        format.html { render :edit }
        format.json { render json: @store_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_products/1
  # DELETE /store_products/1.json
  def destroy
    @store_product.destroy
    respond_to do |format|
      format.html { redirect_to store_products_url, notice: 'Store product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_product
      @store_product = StoreProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_product_params
      params.require(:store_product).permit(:user_id, :product_id, :price, :stock, :in_w, :in_r)
    end
end
