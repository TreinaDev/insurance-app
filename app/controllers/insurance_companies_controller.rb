class InsuranceCompaniesController < ApplicationController
  before_action :check_admin, only: %i[index]
  def index
    @insurance_companies = InsuranceCompany.all
  end

  def show
    @insurance_company = InsuranceCompany.find(params[:id])
  end
end
