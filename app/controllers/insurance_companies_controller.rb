class InsuranceCompaniesController < ApplicationController
  def index
    @insurance_companies = InsuranceCompany.all
  end
end
