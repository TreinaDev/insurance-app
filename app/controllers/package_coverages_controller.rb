class PackageCoveragesController < ApplicationController
  before_action :check_admin, only: %i[new create]

  def index
    @package_coverages = PackageCoverage.all
  end

  def new
    @package_coverage = PackageCoverage.new
  end

  def create
    @package_coverage = PackageCoverage.new(package_coverage_params)
    if @package_coverage.save
      flash[:notice] = t('.success')
      redirect_to package_coverages_path
    else
      flash.now[:alert] = t('.failure')
      render 'new'
    end
  end

  private

  def package_coverage_params
    params.require(:package_coverage).permit(:name, :description)
  end
end
