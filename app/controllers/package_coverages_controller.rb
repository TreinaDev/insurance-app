class PackageCoveragesController < ApplicationController
  def index
    @package_coverages = PackageCoverage.all
  end
end
