class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return500
  rescue_from ActiveRecord::RecordNotFound, with: :return404

  def create_package_json(package, product)
    p = package.as_json(except: %i[created_at updated_at status])
    p[:coverages] = package.package_coverages
    p[:services] = package.package_services
    p[:price_per_month] = (package.price * product.price) / 100
    p[:insurance_company_name] = package.insurance_company.name
    p
  end

  private

  def return500
    render status: :internal_server_error, json: {}
  end

  def return404
    render status: :not_found, json: {}
  end
end
