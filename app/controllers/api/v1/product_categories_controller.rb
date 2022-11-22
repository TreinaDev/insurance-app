class Api::V1::ProductCategoriesController < Api::V1::ApiController
  def index
    product_categories = ProductCategory.all.order(:name)
    render status: :ok, json: product_categories
  end

  def products
    product_category = ProductCategory.find(params[:id])
    products = product_category.products
    render status: :ok, json: products.map { |p| create_product_json(p) }
  end

  def create_product_json(product)
    product_json = product.as_json(except: %i[created_at updated_at])
    product_json[:image_url] = url_for(product.image) if product.image.attached?
    product_json
  end
end
