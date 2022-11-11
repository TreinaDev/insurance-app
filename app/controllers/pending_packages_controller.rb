class PendingPackagesController < ApplicationController
  def index
    @pending_packages = if current_user.admin?
                          PendingPackage.all.order(:product_category)
                        else
                          current_user.insurance_company.pending_packages
                        end
  end
end