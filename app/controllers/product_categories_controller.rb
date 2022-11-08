class ProductCategoriesController < ApplicationController
  def index
    @product_categories = ProductCategory.all
  end

  def new
    @product_category = ProductCategory.new
  end

  def create
    product_category_params = params.require(:product_category).permit(:name)
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      redirect_to product_categories_path, notice: (t '.success')
    else
      flash.now[:notice] = (t '.fail')
      render 'new'
    end
  end

  private

  def product_category_params
    params.require(:product_category).permit(:name)
  end
end
