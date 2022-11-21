class Api::V1::ProductsController < Api::V1::ApiController
  def index
    products = Product.all.order(:product_model)
    render status: :ok, json: products.map { |p| create_json(p) }
  end

  def show
    product = Product.find(params[:id])
    render status: :ok, json: create_json(product)
  end

  private

  def create_json(product)
    p = product.as_json(except: %i[created_at updated_at])
    p[:image_url] = url_for(product.image) if product.image.attached?
    p
  end
end
