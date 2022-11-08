module Api
  module V1
    class InsuranceCompaniesController < ActionController::API
      def index
        admin_company = InsuranceCompany.find_by(name: 'Empresa')
        insurance_companies = InsuranceCompany.all - [admin_company]
        render status: :ok, json: insurance_companies
      end
    end
  end
end
