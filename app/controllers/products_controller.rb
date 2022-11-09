class ProductsController < ApplicationController
  before_action :check_admin, only: %i[activate deactivate new create edit update]
  before_action :set_product, only: %i[show activate deactivate update edit]

  def index
    @categories = ProductCategory.all.order(:name)
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

  def edit; end

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
    if @product.update(product_params)
      flash[:notice] = t('.update_success')
      redirect_to @product
    else
      flash.now[:notice] = t('.update_failure')
      render 'edit'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_model, :launch_year, :brand, :price,
                                    :product_category_id, :image)
  end
end
