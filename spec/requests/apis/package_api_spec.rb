require 'rails_helper'

describe 'Package API' do
  context 'GET /api/v1/packages' do
    it 'sucesso' do
      product_category = ProductCategory.create!(name: 'Televisão')
      insurance_company_a = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '00000000000000')
      insurance_company_b = InsuranceCompany.create!(name: 'Seguradora B', email_domain: 'seguradorab.com.br',
                                                     registration_number: '00000000000001')
      Package.create!(name: 'Pacote 1', max_period: 12, min_period: 6, insurance_company: insurance_company_a,
                      price: 25.99, product_category:)
      Package.create!(name: 'Pacote 2', max_period: 10, min_period: 5, insurance_company: insurance_company_b,
                      price: 35.99, product_category:)
      Package.create!(name: 'Pacote 3', max_period: 15, min_period: 7, insurance_company: insurance_company_b,
                      price: 30.00, product_category:)

      get '/api/v1/packages'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 3
    end
  end
end
