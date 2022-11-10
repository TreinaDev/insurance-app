class PackagesController < ApplicationController
  def index
    if current_user.admin?
      @packages = Package.all.order(:product_category)
    end
    @packages = Package.where("insurance_company_id = ?", current_user.insurance_company_id)
  end
end
