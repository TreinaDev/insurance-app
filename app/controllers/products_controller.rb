class ProductsController < ApplicationController

  def new 
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save()
      flash[:notice] = 'Produto criado com sucesso!'
      redirect_to new_product_path
    else
      flash[:notice] = 'Produto não foi criado'
      render 'new'
    end 
  end


  private
  def product_params
    product_params = params.require(:product).permit(:product_model, :launch_year, :brand, :price, 
                                                    :status, :product_category_id)
  end
end