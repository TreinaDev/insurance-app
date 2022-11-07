class ProductsController < ApplicationController
  before_action :check_if_admin, only: %i[new create]
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

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = t('.success')
      redirect_to products_path
    else
      flash.now[:notice] = t('.failure')
      render 'new'
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_model, :launch_year, :brand, :price,
                                    :status, :product_category_id)
  end

  def check_if_admin
    redirect_to root_path, notice: t('.authorization_failure') if current_user.employee?
  end
end
