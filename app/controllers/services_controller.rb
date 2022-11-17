class ServicesController < ApplicationController
  before_action :check_admin, only: %i[new create]

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      flash[:notice] = t('.success')
      redirect_to services_path
    else
      flash.now[:alert] = t('.failure')
      render 'new'
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :status, :code)
  end
end
