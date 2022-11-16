class Api::V1::PackageCoveragesController < Api::V1::ApiController
  def index
    package_coverages = PackageCoverage.all.order(:package_coverage_model)
    render status: :ok, json: package_coverages.as_json(except: %i[created_at updated_at])
  end
end
