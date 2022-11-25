class Api::V1::InsuranceCompaniesController < Api::V1::ApiController
  def index
    insurance_companies = InsuranceCompany.all.order(:name)
    render status: :ok, json: insurance_companies.map { |ic| create_json(ic) }
  end

  def show
    insurance_company = InsuranceCompany.find(params[:id])
    render status: :ok, json: create_json(insurance_company)
  end

  def query
    email = params[:id]
    insurance_company = InsuranceCompany.find_by(email_domain: email.partition('@').last)
    if insurance_company.nil?
      return404
    else
      render status: :ok, json: create_json(insurance_company)
    end
  end

  private

  def create_json(insurance_company)
    ic = insurance_company.as_json(except: %i[created_at updated_at])
    ic[:logo_url] = url_for(insurance_company.logo) if insurance_company.logo.attached?
    ic
  end
end
