class ServicePricingsController < ApplicationController
  def create
    @package = Package.find(params[:package_id])
    @service_pricing = ServicePricing.new(service_pricing_params)
    @service_pricing.package = @package
    if @service_pricing.save
      redirect_to package_url(@package.id), notice: t('add_service_success')
    else
      redirect_to package_url(@package.id), alert: t('add_service_error')
    end
  end

  private

  def service_pricing_params
    params.require(:service_pricing).permit(:service_id, :percentage_price)
  end
end
