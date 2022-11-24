class Api::V1::PackagesController < Api::V1::ApiController
  def index
    packages = Package.active
    render status: :ok, json: packages.as_json(except: %i[created_at updated_at])
  end

  def show
    if params[:product_id].nil?
      package = Package.find(params[:id])
      render status: :ok, json: package.as_json(except: %i[created_at updated_at])
    else
      product = Product.find(params[:product_id])
      package = Package.find(params[:id])
      render status: :ok, json: create_package_json(package, product)
    end
  end
end
