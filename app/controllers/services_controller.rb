class ServicesController < ApplicationController
  before_action :check_admin, only: %i[new create]

  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
    @services = Service.all
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

  def activate
    @service = Service.find(params[:id])
    @service.active!
    redirect_to @service, notice: t('.success')
  end

  def deactivate
    @service = Service.find(params[:id])
    @service.inactive!
    redirect_to @service, notice: t('.success')
  end

  private

  def service_params
    params.require(:service).permit(:name, :description)
  end
end
