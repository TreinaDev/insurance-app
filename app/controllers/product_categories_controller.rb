class ProductCategoriesController < ApplicationController
  def index
    @product_categories = ProductCategory.all
  end

  def new
    @product_category = ProductCategory.new()
  end
  def create
    product_category_params = params.require(:product_category).permit(:name)
    
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
     redirect_to product_categories_path, notice: 'Categoria de produto cadastrada com sucesso!'
    else
      flash.now[:notice] = 'Ocorreu um erro.'
      render 'new'
    end

  end

  private

  def product_category_params
    params.require(:product_category).permit(:name)
  end
end