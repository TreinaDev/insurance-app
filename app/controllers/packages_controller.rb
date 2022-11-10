class PackagesController < ApplicationController
  def index
    @categories = ProductCategory.all.order(:name)
    @packages = Package.all
  end
end
