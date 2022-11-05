class ProductsController < ApplicationController
  before_action :check_user

  def index
    @products = Product.all
  end
end
