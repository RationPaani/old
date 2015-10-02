class StoresController < ApplicationController
  before_action :set_store, only: [:show, :setprice, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new]
  before_filter :require_permission, only: [:edit, :update, :destroy]

def require_permission
  if current_user != @store.user
    redirect_to user_path
    #Or do something else here
  end
end

  # GET /stores
  # GET /stores.json
  def index
  if (params[:storetype] == "stores")
    @stores = Store.all.text_search(params[:query]).page(params[:page]).per_page(15)
    else if(params[:storetype] == "retail")
    @stores = Store.all.where(:storetype => 0).text_search(params[:query]).page(params[:page]).per_page(15)
    else if(params[:storetype] == "eatery")
    @stores = Store.all.where(:storetype => 1).text_search(params[:query]).page(params[:page]).per_page(15)
    else if(params[:storetype] == "wholesale")
    @stores = Store.all.where(:storetype => 2).text_search(params[:query]).page(params[:page]).per_page(15)
    else if(params[:storetype] == "logistics" || params[:storetype] == "logistic")
    @stores = Store.all.where(:storetype => 3).text_search(params[:query]).page(params[:page]).per_page(15)
    end
    end
    end
    end
   end
  end
  
  def setprice
 @product = Store.find(params[:id]).store_products
  @products = @product.page(params[:page]).per_page(9)
  end
  def updateprice
  StoreProduct.update(params[:prices].keys, params[:prices].values)
  redirect_to setprice_path
 end
  # GET /stores/1
  # GET /stores/1.json
  def show
  
  def categ(parama)
  oils = ["Mustard Oil", "Soya Oil", "Desi Ghee", "Vanaspati Ghee"]
  dal = ["Chana", "Matar", "Arahar", "Moong", "Urad", "Masoor", "Rajma"]
  atta = ["Atta", "Wheat Atta", "Rice Atta", "Corn Atta", "Oat Atta", "Maida", "Besan", "Suji"]
  rtc = ["Noodles", "Sevaiyan", "Chowmein", "Pasta", "Macroni", "Ready to Cook"]
  adons = ["Pickels", "Sauce", "Butter", "Jam"]
  bakdairy = ["Milk", "Biscuits"]
  tea = ["Tea", "Coffee"]
  baverage =["Cold Drinks", "Fruit Juice"]
  grocery = [oils, dal, atta, rtc, adons, bakdairy, tea, baverage, "rice", "Masale"]
  haircare = ["Shampoo", "Hair Oils", "Conditionar"]
  bath = [haircare, "Bathing soap", "Detergent", "Cream and Talk", "Tooth Care", "Grooming"]
  if(parama == "oils")
  return oils
  else if(parama == "dal")
  return dal
  else if(parama == "atta")
  return atta
  else if(parama == "rtc")
  return rtc
  else if(parama == "adons")
  return adons
  else if(parama == "bakdairy")
  return bakdairy
  else if(parama == "tea")
  return tea
  else if(parama == "baverage")
  return baverage
  else if(parama == "haircare")
  return haircare
  else if(parama == "bath")
  return bath
  else if(parama == "grocery")
  grocery.each do |metoo|
  categ(metoo)
  end
  else if(parama == "bath")
  bath.each do |metoo|
  categ(metoo)
  end
  else 
  paramaa = Array.new
  paramaa << parama
  return paramaa
  
  end
  end
  end
  end
  end
  end
  end
  end
  end
  end
  end
  end
  
  
  end
  
  finalparama = Array.new
  finalparama.concat(categ(params[:cat]))
  
  @product = Store.find(params[:id]).products
  if (!params[:cat] || params[:cat] == "")
    @products = @product.text_search(params[:query]).page(params[:page]).per_page(9)
    else
    @products = @product.text_search(params[:query]).where(category: finalparama).page(params[:page]).per_page(9)
  end
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)
    @store.user_id = current_user.id

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:storetype, :name, :image, :detail, :offer, :state, :city, :zip, :add1, :add2, :enable)
    end
end
