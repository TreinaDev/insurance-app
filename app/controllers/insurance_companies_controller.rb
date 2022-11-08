class InsuranceCompaniesController < ApplicationController
  def index
    @insurance_companies = InsuranceCompany.all.filter { |insurance| insurance.email_domain != 'empresa.com.br' }
  end
end
