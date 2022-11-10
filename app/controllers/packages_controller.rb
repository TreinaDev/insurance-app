class PackagesController < ApplicationController
  def index
    @packages = if current_user.admin?
                  Package.all.order(:product_category)
                else
                  Package.where(insurance_company_id: current_user.insurance_company_id)
                end
  end
end
