class Api::V1::InsuranceCompaniesController < Api::V1::ApiController
  def index
    insurance_companies = InsuranceCompany.all.order(:name)
    render status: :ok, json: insurance_companies
  end

  def show
    insurance_company = InsuranceCompany.find(params[:id])
    render status: :ok, json: insurance_company.as_json(except: %i[created_at updated_at])
  end
end
