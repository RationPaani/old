class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end
  def subcategories
  subs = []
  @category = Store.find(params[:id]).categories
  @category.each do |cato|
    cato.subcates.each do |ca|
      subs << ca
    end
  end
  @subable = @category.where("id not in (?) AND name != ? ", subs, "All")
  end
  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    params[:name].values.each do |n|
      if(n != "")
      @category = Category.new
      @category.store_id = params[:store_id]
      @category.name = n
      @category.save
      end
    end
    redirect_to user_path
  end

  def subcategorise
    params[:item_checked].each_with_index do |item_check, index|
      if(params[:catsub]["category_id"] != params[:item_checked].values[index])
    @item = Catsub.new
    @item.subcate_id = params[:item_checked].values[index]
    @item.category_id = params[:catsub]["category_id"]
    @item.save
    end
    end
    redirect_to user_path
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:belongs_to, :name, :subcats, :filterables)
    end
end
