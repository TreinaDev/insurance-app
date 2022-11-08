class ProductsController < ApplicationController
  before_action :check_admin, only: %i[activate deactivate new create]
  before_action :set_product, only: %i[show activate deactivate]

  def index
    @products = Product.all
  end

  def show; end

  def activate
    @product.active!
    redirect_to @product, notice: t('.success')
  end

  def deactivate
    @product.inactive!
    redirect_to @product, notice: t('.success')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = t('.success')
      redirect_to @product
    else
      flash.now[:notice] = t('.failure')
      render 'new'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_model, :launch_year, :brand, :price,
                                    :status, :product_category_id)
  end
end
