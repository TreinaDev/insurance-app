class Api::V1::ProductsController < Api::V1::ApiController
  def index
    products = Product.all.order(:product_model)
    render status: 200, json: products
  end
end
