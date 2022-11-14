class Api::V1::PackagesController < Api::V1::ApiController
  def index
    packages = Package.active
    render status: :ok, json: packages
  end
end
