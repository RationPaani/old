class ProductsController < ApplicationController
  
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update]
  before_filter :require_permission, only: [:edit, :update, :destroy]

def require_permission
  if(current_user != @product.store.user)
    redirect_to user_path
    #Or do something else here
  end
end 

  def index
    @products = Product.text_search(params[:query]).page(params[:page]).per_page(12)
    #@products = Product.paginate(:per_page => 5, :page => params[:page])
  end
  
 def upload
  uploaded_io = params[:person][:picture]
  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
  end
end

  # GET /products/1
  # GET /products/1.json
  def show
   @store = @product.store
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @store = Store.find(params[:store])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
  uploaded_io = params[:product][:image]
  directry = Rails.root.join('app/images', @product.store_id.to_s)
  Dir.mkdir(directry) unless File.exists?(directry)
  File.open(File.join(directry, uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
  end   
    @product.image = uploaded_io.original_filename

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if (params[:product][:image])
      uploaded_io = params[:product][:image]
      directry = Rails.root.join('public/images', @product.store_id.to_s)
      Dir.mkdir(directry) unless File.exists?(directry)
        File.open(File.join(directry, uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end
    respond_to do |format| 
      if @product.update(product_params)
        if (params[:product][:image])
        @product.update(:image => uploaded_io.original_filename)
      end
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :store_id, :brand, :category, :image, :unit, :spec, :price, :referer)
    end
end
