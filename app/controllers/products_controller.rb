class ProductsController < ApplicationController
<<<<<<<<< Temporary merge branch 1
    def show 
        @product = Product.find(params[:id])
    end
=========

  def index
    @products = Product.all
  end
>>>>>>>>> Temporary merge branch 2
end