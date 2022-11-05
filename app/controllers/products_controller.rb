class ProductsController < ApplicationController
  before_action :check_if_admin, only: [:new, :create]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'Produto criado com sucesso!'
      redirect_to new_product_path
    else
      flash.now[:notice] = 'Produto não foi criado'
      render 'new'
    end
  end

  private

  def product_params
    product_params = params.require(:product).permit(:product_model, :launch_year, :brand, :price,
                                                    :status, :product_category_id)
  end

  def check_if_admin
    if current_user.employee?
      flash[:notice] = 'Apenas usuários administradores tem acesso a essa função'
      redirect_to root_path
    end
  end
end