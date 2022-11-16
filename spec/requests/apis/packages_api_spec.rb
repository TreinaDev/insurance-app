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
                      product_category_id: product_category.id, price: 1.1, status: :active)
      Package.create!(name: 'Pacote 2', max_period: 6, min_period: 15, insurance_company: insurance_company_b,
                      product_category_id: product_category.id, price: 3.5, status: :inactive)
      Package.create!(name: 'Pacote 3', max_period: 10, min_period: 5, insurance_company: insurance_company_b,
                      product_category_id: product_category.id, price: 2.5, status: :active)
      Package.create!(name: 'Pacote 4', max_period: 20, min_period: 9, insurance_company: insurance_company_a,
                      product_category_id: product_category.id, price: 2, status: :pending)

      get '/api/v1/packages'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Pacote 1'
      expect(json_response[0].keys).not_to include('created_at')
      expect(json_response[0].keys).not_to include('updated_at')
      expect(json_response[1]['name']).to eq 'Pacote 3'
      expect(json_response[1].keys).not_to include('created_at')
      expect(json_response[1].keys).not_to include('updated_at')
    end

    it 'retorna vazio caso não existam pacotes ativos' do
      product_category = ProductCategory.create!(name: 'Televisão')
      insurance_company_a = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '00000000000000')
      Package.create!(name: 'Pacote 2', max_period: 6, min_period: 15, insurance_company: insurance_company_a,
                      product_category_id: product_category.id, price: 3.5, status: :inactive)
      Package.create!(name: 'Pacote 4', max_period: 20, min_period: 9, insurance_company: insurance_company_a,
                      product_category_id: product_category.id, price: 2, status: :pending)

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
      package = Package.create!(name: 'Pacote 1', max_period: 12, min_period: 6, insurance_company: insurance_company_a,
                                product_category_id: product_category.id, price: 1.1, status: :active)

      get "/api/v1/packages/#{package.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'Pacote 1'
      expect(json_response['max_period']).to eq 12
      expect(json_response['min_period']).to eq 6
      expect(json_response['insurance_company_id']).to eq insurance_company_a.id
      expect(json_response['product_category_id']).to eq product_category.id
      expect(json_response['price']).to eq '1.1'
      expect(json_response['status']).to eq 'active'
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'falha se o pacote não é encontrado' do
      get '/api/v1/packages/9999999999999999999999'

      expect(response.status).to eq 404
    end
  end
end
