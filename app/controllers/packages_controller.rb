class PackagesController < ApplicationController
  def index
    @packages = if current_user.admin?
                  Package.all.order(:product_category)
                else
                  current_user.insurance_company.packages
                end
  end
end
