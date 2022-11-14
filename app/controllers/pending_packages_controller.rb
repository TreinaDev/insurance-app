class PendingPackagesController < ApplicationController
  def index
    @pending_packages = if current_user.admin?
                          PendingPackage.all.order(:product_category)
                        else
                          current_user.insurance_company.pending_packages
                        end
  end

  def new
    @pending_package = PendingPackage.new
  end

  def create
    @pending_package = PendingPackage.new(pending_package_params)
    @pending_package.insurance_company_id = current_user.insurance_company_id
    if @pending_package.save
      flash[:notice] = t('.success')
      redirect_to pending_packages_path
    else
      flash.now[:alert] = t('.failure')
      render 'new'
    end
  end

  private

  def pending_package_params
    params.require(:pending_package).permit(:name, :min_period, :max_period, :insurance_company_id,
                                            :product_category_id)
  end
end
