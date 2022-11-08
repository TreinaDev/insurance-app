class ProductsController < ApplicationController
  before_action :check_admin, only: [:activate, :deactivate]
  before_action :set_product, only: [:show, :activate, :deactivate]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def activate
    @product.active!
    redirect_to @product, notice: 'Produto ativado com sucesso'
  end

  def deactivate
    @product.inactive!
    redirect_to @product, notice: 'Produto desativado com sucesso'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
