class Api::V1::ServicesController < Api::V1::ApiController
  def index
    services = Service.all.order(:service_model)
    render status: :ok, json: services.as_json(except: %i[created_at updated_at])
  end
end
