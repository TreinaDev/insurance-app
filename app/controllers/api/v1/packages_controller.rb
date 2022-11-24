class Api::V1::PackagesController < Api::V1::ApiController
  def index
    packages = Package.active
    render status: :ok, json: packages.as_json(except: %i[created_at updated_at])
  end

  def show
    @package = Package.find(params[:id])
    if params[:product_id].nil?
      render status: :ok, json: @package.as_json(except: %i[created_at updated_at])
    else
      @product = Product.find(params[:product_id])
      api_show
    end
  end

  private

  def api_show
    if @product.product_category == @package.product_category
      render status: :ok, json: create_package_json(@package, @product)
    else
      return404
    end
  end
end
