class InsuranceCompaniesController < ApplicationController
  before_action :check_if_admin, only: %i[index]
  def index
    @insurance_companies = InsuranceCompany.all.filter { |insurance| insurance.email_domain != 'empresa.com.br' }
  end
end
