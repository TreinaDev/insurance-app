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
    @coverage_pricing = CoveragePricing.new
    @coverage_pricings = @package.coverage_pricings
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

  private

  def package_params
    params.require(:package).permit(:name, :min_period, :max_period, :insurance_company_id,
                                    :product_category_id)
  end
end
