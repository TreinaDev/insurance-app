require 'rails_helper'

describe 'Package API' do
  context 'GET /api/v1/packages' do
    it 'sucesso' do
      product_category = ProductCategory.create!(name: 'Televisão')
      insurance_company_a = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '00000000000000')
      insurance_company_b = InsuranceCompany.create!(name: 'Seguradora B', email_domain: 'seguradorab.com.br',
                                                     registration_number: '00000000000001')
      pp1 = PendingPackage.create!(name: 'Pacote 1', max_period: 12, min_period: 6,
                                   insurance_company: insurance_company_a,
                                   product_category_id: product_category.id)
      pp2 = PendingPackage.create!(name: 'Pacote 2', max_period: 10, min_period: 5,
                                   insurance_company: insurance_company_b,
                                   product_category_id: product_category.id)
      Package.create!(price: 1.1, pending_package_id: pp1.id, status: :active)
      Package.create!(price: 2.5, pending_package_id: pp2.id, status: :active)

      get '/api/v1/packages'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
    end

    it 'retorna vazio caso não exista nenhum pacote' do
      get '/api/v1/packages'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'e retorna erro interno' do
      allow(Package).to receive(:all).and_raise(ActiveRecord::QueryAborted)

      get '/api/v1/packages'

      expect(response).to have_http_status 500
    end
  end

  context 'GET /api/v1/packages/1' do
    it 'sucesso' do
      product_category = ProductCategory.create!(name: 'Televisão')
      insurance_company_a = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '00000000000000')
      pending_package = PendingPackage.create!(name: 'Pacote 1', max_period: 12, min_period: 6,
                                               insurance_company: insurance_company_a,
                                               product_category_id: product_category.id)
      package = Package.create!(price: 1.1, pending_package_id: pending_package.id, status: :active)

      get "/api/v1/packages/#{package.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response['price']).to eq '1.1'
      expect(json_response['status']).to eq 'active'
      expect(json_response['pending_package_id']).to eq pending_package.id
    end

    it 'falha se o pacote não é encontrado' do
      get '/api/v1/packages/9999999999999999999999'

      expect(response.status).to eq 404
    end
  end
end
