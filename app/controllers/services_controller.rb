class ServicesController < ApplicationController
  before_action :check_admin, only: %i[new create]
  def index
    @services = Service.all
  end
  def new
    @service = Service.new()
  end
  def create
    @service = Service.new(service_params)
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :status, :code)
  end

end
