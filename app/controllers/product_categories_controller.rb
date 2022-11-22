class ProductCategoriesController < ApplicationController
  def index
    @product_categories = ProductCategory.all
  end

  def show
    @category = ProductCategory.find(params[:id])
    @products = @category.products
  end

  def new
    @product_category = ProductCategory.new
    @product_categories = ProductCategory.all
  end

  def create
    product_category_params = params.require(:product_category).permit(:name)
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      redirect_to product_categories_path, notice: (t '.success')
    else
      flash.now[:alert] = (t '.fail')
      @product_categories = ProductCategory.all
      render 'new'
    end
  end
end
