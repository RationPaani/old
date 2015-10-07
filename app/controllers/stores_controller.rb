class StoresController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :subcsribe]
  before_filter :checkuri, only: [:new_product, :show, :orders]
  before_filter :checkperm, only: [:new_product]
  before_action :set_store, only: [:show, :edit, :retail, :eatery, :wholesale, :logistics, :setprice, :edit, :update, :destroy, :orders]
  before_filter :require_permission, only: [:edit, :update, :destroy, :orders]

def require_permission
  if current_user != @store.user
    redirect_to user_path
    #Or do something else here
  end
end
def checkuri
  unless(Store.exists?(:id => params[:id]) && (["retail", "wholesale", "logistics", "eatery", "stores", "images"].include? (params[:store])))
      render :template => 'error_pages/404', :layout => false, :status => :not_found
    #Or do something else here
  end
end
def checkperm
unless (current_user == Store.find(params[:id]).user)
redirect_to user_path
end
end
  # GET /stores
  # GET /stores.json
  def index
  if (params[:storetype] == 'stores')
    @stores = Store.all.text_search(params[:query]).page(params[:page]).per_page(15)
    else if(params[:storetype] == 'retail')
    @stores = Store.all.where(:storetype => 'retail').text_search(params[:query]).page(params[:page]).per_page(15)
    else if(params[:storetype] == 'eatery')
    @stores = Store.all.where(:storetype => 'eatery').text_search(params[:query]).page(params[:page]).per_page(15)
    else if(params[:storetype] == 'wholesale')
    @stores = Store.all.where(:storetype => 'wholesale').text_search(params[:query]).page(params[:page]).per_page(15)
    else if(params[:storetype] == 'logistics' || params[:storetype] == 'logistic')
    @stores = Store.all.where(:storetype => 'logistics').text_search(params[:query]).page(params[:page]).per_page(15)
    end
    end
    end
    end
   end
  end
   
   def new_product # New product addition 
    @product = Product.new
    @store = Store.find(params[:id])
   end


  def setprice
 @product = Store.find(params[:id]).products
  @products = @product.page(params[:page]).per_page(9)
  end
  def updateprice
  Product.update(params[:prices].keys, params[:prices].values)
  redirect_to setprice_path
 end
  # GET /stores/1
  # GET /stores/1.json
 def subcsribe
  @fav = Favourite.new
  @fav.user = current_user
  @fav.store = Store.find(params[:id])
  @fav.save
  redirect_to(:back)
 end
 def eatery
 @products = Store.find(params[:id]).products.text_search(params[:query]).page(params[:page]).per_page(15)
 end
 def wholesale
 @products = Store.find(params[:id]).products.text_search(params[:query]).page(params[:page]).per_page(15)
 end
 def logistics
 @products = Store.find(params[:id]).products.text_search(params[:query]).page(params[:page]).per_page(15)
 end
 def show
  if(params[:cat] && params[:cat] != "")
    @store = Store.find(params[:id])
 @products = @store.products.where(category: @store.categories.where(name: params[:cat])).text_search(params[:query]).page(params[:page]).per_page(15)
else
  @products = Store.find(params[:id]).products.text_search(params[:query]).page(params[:page]).per_page(15)
end
 subs = []
  @category = @store.categories
  @category.each do |cato|
    cato.subcates.each do |ca|
      subs << ca
    end
  end
  @maincats = subs.any? ? @category.where("id NOT IN (?)", subs) : @category
 end
  def retail
  
  def categ(parama)
  someobj = {
  'oils' => ['Mustard Oil', 'Soya Oil', 'Desi Ghee', 'Vanaspati Ghee'],
  'dal' => ['Chana', 'Matar', 'Arahar', 'Moong', 'Urad', 'Masoor', 'Rajma'],
  'atta' => ['Atta', 'Wheat Atta', 'Rice Atta', 'Corn Atta', 'Oat Atta', 'Maida', 'Besan', 'Suji'],
  'rtc' => ['Noodles', 'Sevaiyan', 'Chowmein', 'Pasta', 'Macroni', 'Ready to Cook'],
  'adons' => ['Pickels', 'Sauce', 'Butter', 'Jam'],
  'bakdairy' => ['Milk', 'Biscuits'],
  'tea' => ['Tea', 'Coffee'],
  'baverage' => ['Cold Drinks', 'Fruit Juice'],
  'haircare' => ['Shampoo', 'Hair Oils', 'Conditionar']
  }
  someobj1 = {'grocery' => [someobj['oils'], someobj['dal'], someobj['atta'], someobj['rtc'], someobj['adons'], someobj['bakdairy'], someobj['tea'], someobj['baverage'], 'rice', 'Masale'],
  'bath' => [someobj['haircare'], 'Bathing soap', 'Detergent', 'Cream and Talk', 'Tooth Care', 'Grooming']
  }
  someobj = someobj.merge(someobj1)
  
  if(someobj[params[:cat]] && someobj[params[:cat]].first.is_a?(Hash) )
  someobj[params[:cat]].each do |metoo|
  categ(metoo.key)
  end
  else if(someobj[params[:cat]])
  return someobj[params[:cat]]
  else
  newarra = Array.new
  newarra << params[:cat]
  return newarra
  end
  end
  end
  
  finalparama = Array.new
  finalparama.concat(categ(params[:cat]))
  if(params[:brand])
  cpbrand = params[:brand].clone
  paramabrand = cpbrand.split("+")
  end
  @product = Store.find(params[:id]).products
  
  if (params[:cat] && params[:cat] != '' && params[:brand] && params[:brand] != '')
  @products = @product.text_search(params[:query]).where(category: finalparama).where(brand: paramabrand).page(params[:page]).per_page(15)
  else if(params[:cat] && params[:cat] != '' && (!params[:brand] || params[:brand] == ''))
  @products = @product.text_search(params[:query]).where(category: finalparama).page(params[:page]).per_page(15)
  else if ((!params[:cat] || params[:cat] == '') && params[:brand] && params[:brand] != "")
  @products = @product.text_search(params[:query]).where(brand: paramabrand).page(params[:page]).per_page(15)
  else
  @products = @product.text_search(params[:query]).page(params[:page]).per_page(15)
  end
  end
  end
  
  
  end

  def new
    @store = Store.new
  end

  def edit
  end
  
def orders
    @orders = @store.orders.where(svis: true)
end
def remove_order
  @order = Order.find([params[:order]]).first
  if(@order.sresponse == 1 || @order.sresponse == 2)
  @order.svis = false
  @order.save
  end
  redirect_to(:back)
end
def reject_order
  @order = Order.find([params[:order]]).first
  @order.sresponse = 2
  @order.save
  redirect_to(:back)
end
def accept_order
  @order = Order.find([params[:order]]).first
  if(@order.sresponse == 2)
  @order.sresponse = 0
  @order.save
  end
  redirect_to(:back)
end
def completed
  @order = Order.find([params[:order]]).first
  if(@order.sresponse != 2)
  @order.sresponse = 1
  @order.save
  end
  redirect_to(:back)
end

def create
    @store = Store.new(store_params)
    @store.user_id = current_user.id
  #  directry = Rails.root.join('app/assets/images', current_user.id.to_s)
  #  Dir.mkdir(directry) unless File.exists?(directry)
  #  uploaded_io = params[:store][:image]    
  #  File.open(File.join(directry, uploaded_io.original_filename), 'wb') do |file|
  #  file.write(uploaded_io.read)
  #  end
  #  @store.image = uploaded_io.original_filename

    respond_to do |format|
      if @store.save
        format.html { redirect_to "/#{@store.storetype}/#{@store.id}", notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

def addimage
  @store = Store.find(params[:id])
  uploaded_io = params[:store][:image]
  File.open(Rails.root.join('app/assets/images', current_user.id.to_s, uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
  end   
    @store.image = uploaded_io.original_filename
    @store.save
end
  
  def update    
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to store_path(:store => "store", :id => @store.id), notice: 'Store was successfully updated.' }
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

     def product_params
      params.require(:product).permit(:name, :brand, :category, :image, :unit, :spec, :price, :referer)
    end
end
