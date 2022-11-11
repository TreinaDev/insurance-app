class Api::V1::PackagesController < Api::V1::ApiController
  def index
    packages = Package.all
    render status: :ok, json: packages
  end

  def show
    package = Package.find(params[:id])
    render status: :ok, json: package.as_json
  end
end
