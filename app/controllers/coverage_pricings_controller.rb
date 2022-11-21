class CoveragePricingsController < ApplicationController
  def create
    @package = Package.find(params[:package_id])
    @coverage_pricing = CoveragePricing.new(coverage_pricing_params)
    @coverage_pricing.package = @package
    if @coverage_pricing.save
      redirect_to package_url(@package.id), notice: t('add_coverage_success')
    else
      redirect_to package_url(@package.id), alert: t('add_coverage_error')
    end
  end

  private

  def coverage_pricing_params
    params.require(:coverage_pricing).permit(:package_coverage_id, :percentage_price)
  end
end
