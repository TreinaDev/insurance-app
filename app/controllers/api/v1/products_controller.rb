class Api::V1::ProductsController < Api::V1::ApiController
  def index
    products = Product.all.order(:product_model)
    render status: :ok, json: products.map { |p| create_json(p) }
  end

  def show
    product = Product.find(params[:id])
    render status: :ok, json: create_json(product)
  end

  def packages
    product = Product.find(params[:id])
    packages = product.product_category.packages.active
    render status: :ok, json: packages.map { |p| create_package_json(p, product) }
  end

  private

  def create_json(product)
    p = product.as_json(except: %i[created_at updated_at])
    p[:image_url] = url_for(product.image) if product.image.attached?
    p
  end

  def create_package_json(package, product)
    p = package.as_json(except: %i[created_at updated_at status])
    p[:coverages] = package.package_coverages
    p[:services] = package.package_services
    p[:price_per_month] = (package.price * product.price) / 100
    p[:insurance_company_name] = package.insurance_company.name
    p
  end
end
