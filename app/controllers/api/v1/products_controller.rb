class Api::V1::ProductsController < Api::V1::ApiController
  def index
    products = Product.all.order(:product_model)
    render status: :ok, json: products
  end

  def show
    product = Product.find(params[:id])
    render status: :ok, json: product.as_json(except: %i[created_at updated_at])
  end
end
