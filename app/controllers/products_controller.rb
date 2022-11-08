class ProductsController < ApplicationController
  before_action :check_if_admin, only: %i[new create edit update]
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
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

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = t('.update_success')
      redirect_to @product
    else
      flash.now[:notice] = t('.update_failure')
      render 'edit'
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_model, :launch_year, :brand, :price,
                                    :status, :product_category_id, :image)
  end
end
