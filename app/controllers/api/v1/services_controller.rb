class Api::V1::ServicesController < Api::V1::ApiController
  def index
    services = Service.all.order(:service_model)
    render status: :ok, json: services
  end
end
