class InsuranceCompaniesController < ApplicationController
  before_action :check_admin, only: %i[index]
  def index
    @insurance_companies = InsuranceCompany.all
  end
end
