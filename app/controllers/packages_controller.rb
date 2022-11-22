class PackagesController < ApplicationController
  def index
    @packages = if current_user.admin?
                  Package.all.order(:product_category)
                else
                  current_user.insurance_company.packages
                end
  end

  def show
    @package = Package.find(params[:id])
    if current_user.admin? || current_user.insurance_company == @package.insurance_company
      @coverage_pricing = CoveragePricing.new
      @coverage_pricings = @package.coverage_pricings
      @service_pricing = ServicePricing.new
      @service_pricings = @package.service_pricings
    else
      redirect_to root_url, alert: t('.error')
    end
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package.new(package_params)
    @package.insurance_company_id = current_user.insurance_company_id if current_user.employee?
    if @package.save
      redirect_to packages_path, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render 'new'
    end
  end

  def activate
    @package = Package.find(params[:id])
    if current_user.insurance_company == @package.insurance_company
      @package.active!
      redirect_to @package, notice: t('.success')
    else
      redirect_to root_url
    end
  end

  private

  def package_params
    params.require(:package).permit(:name, :min_period, :max_period, :insurance_company_id,
                                    :product_category_id)
  end
end
