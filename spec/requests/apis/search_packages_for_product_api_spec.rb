require 'rails_helper'

describe 'Search Packages for Product API' do
  context 'GET api/v1/products/1/packages' do
    it 'com sucesso' do
      insurance_company_a = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '00000000000000')
      insurance_company_b = InsuranceCompany.create!(name: 'Seguradora B', email_domain: 'seguradorab.com.br',
                                                     registration_number: '00000000000001')

      smartphones = ProductCategory.create!(name: 'Smartphones')
      product = Product.create!(product_model: 'iPhone 13 Pro', launch_year: '2021',
                                brand: 'Apple', price: 5000, product_category: smartphones)

      Package.create!(name: 'Econômico', min_period: 12, max_period: 24, insurance_company: insurance_company_a,
                      product_category: smartphones, status: :active, price: 1.04)
      Package.create!(name: 'Premium', min_period: 6, max_period: 18, insurance_company: insurance_company_b,
                      product_category: smartphones, status: :active, price: 1.22)

      get "/api/v1/products/#{product.id}/packages"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Econômico'
      expect(json_response[0]['max_period']).to eq 24
      expect(json_response[0]['min_period']).to eq 12
      expect(json_response[0]['insurance_company_id']).to eq insurance_company_a.id
      expect(json_response[0]['insurance_company_name']).to eq 'Seguradora A'
      expect(json_response[0]['product_category_id']).to eq smartphones.id
      expect(json_response[0]['price_per_month']).to eq '52.0'
      expect(json_response[0].keys).not_to include('created_at')
      expect(json_response[0].keys).not_to include('updated_at')
      expect(json_response[0].keys).not_to include('status')

      expect(json_response[1]['name']).to eq 'Premium'
      expect(json_response[1]['max_period']).to eq 18
      expect(json_response[1]['min_period']).to eq 6
      expect(json_response[1]['insurance_company_id']).to eq insurance_company_b.id
      expect(json_response[1]['insurance_company_name']).to eq 'Seguradora B'
      expect(json_response[1]['product_category_id']).to eq smartphones.id
      expect(json_response[1]['price_per_month']).to eq '61.0'
      expect(json_response[1].keys).not_to include('created_at')
      expect(json_response[1].keys).not_to include('updated_at')
      expect(json_response[1].keys).not_to include('status')
    end

    it 'e obtém somente pacotes ativos' do
      insurance_company_a = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '00000000000000')
      insurance_company_b = InsuranceCompany.create!(name: 'Seguradora B', email_domain: 'seguradorab.com.br',
                                                     registration_number: '00000000000001')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      product = Product.create!(product_model: 'iPhone 13 Pro', launch_year: '2021',
                                brand: 'Apple', price: 5000, product_category: smartphones)
      Package.create!(name: 'Econômico', min_period: 12, max_period: 24, insurance_company: insurance_company_a,
                      product_category: smartphones, status: :active, price: 1.04)
      Package.create!(name: 'Max', max_period: 20, min_period: 9, insurance_company: insurance_company_a,
                      product_category: smartphones, status: :pending)
      Package.create!(name: 'Super', max_period: 12, min_period: 6, insurance_company: insurance_company_b,
                      product_category: smartphones, status: :inactive)

      get "/api/v1/products/#{product.id}/packages"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]['name']).to eq 'Econômico'
    end

    it 'com obtém coberturas para um pacote' do
      insurance_company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                   registration_number: '00000000000000')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      product = Product.create!(product_model: 'iPhone 13 Pro', launch_year: '2021',
                                brand: 'Apple', price: 5000, product_category: smartphones)
      package_a = Package.create!(name: 'Econômico', min_period: 12, max_period: 24, insurance_company:,
                                  product_category: smartphones, status: :active, price: 0.71)
      coverage1 = PackageCoverage.create!(name: 'Molhar',
                                          description: 'Assistência por danificação devido a molhar o aparelho.')
      coverage2 = PackageCoverage.create!(name: 'Quebra de tela',
                                          description: 'Assistência por danificação da tela do aparelho.')
      CoveragePricing.create!(percentage_price: 0.30, package: package_a, package_coverage: coverage1)
      CoveragePricing.create!(percentage_price: 0.41, package: package_a, package_coverage: coverage2)

      get "/api/v1/products/#{product.id}/packages"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response[0]['coverages'].length).to eq 2
      expect(json_response[0]['coverages'][0]['code']).to eq coverage1.code
      expect(json_response[0]['coverages'][0]['name']).to eq 'Molhar'
      expect(json_response[0]['coverages'][0]['description']).to eq coverage1.description
      expect(json_response[0]['coverages'][1]['code']).to eq coverage2.code
      expect(json_response[0]['coverages'][1]['name']).to eq 'Quebra de tela'
      expect(json_response[0]['coverages'][1]['description']).to eq coverage2.description
    end
    it 'com obtém serviços para um pacote' do
      insurance_company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                   registration_number: '00000000000000')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      product = Product.create!(product_model: 'iPhone 13 Pro', launch_year: '2021',
                                brand: 'Apple', price: 5000, product_category: smartphones)
      package_a = Package.create!(name: 'Econômico', min_period: 12, max_period: 24, insurance_company:,
                                  product_category: smartphones, status: :active, price: 0.33)
      s1 = Service.create!(name: 'Desconto Petlove',
                           description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.')
      s2 = Service.create!(name: 'Assinatura TV',
                           description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
      ServicePricing.create!(percentage_price: 0.16, package: package_a, service: s1)
      ServicePricing.create!(percentage_price: 0.17, package: package_a, service: s2)

      get "/api/v1/products/#{product.id}/packages"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response[0]['services'].length).to eq 2
      expect(json_response[0]['services'][0]['code']).to eq s1.code
      expect(json_response[0]['services'][0]['name']).to eq 'Desconto Petlove'
      expect(json_response[0]['services'][0]['description']).to eq s1.description
      expect(json_response[0]['services'][1]['code']).to eq s2.code
      expect(json_response[0]['services'][1]['name']).to eq 'Assinatura TV'
      expect(json_response[0]['services'][1]['description']).to eq s2.description
    end
    it 'e não existem pacotes para o produto' do
      insurance_company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                   registration_number: '00000000000000')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      tvs = ProductCategory.create!(name: 'Televisões')
      product = Product.create!(product_model: 'iPhone 13 Pro', launch_year: '2021',
                                brand: 'Apple', price: 5000, product_category: smartphones)
      Package.create!(name: 'Econômico', min_period: 12, max_period: 24, insurance_company:,
                      product_category: tvs, status: :active, price: 0.33)

      get "/api/v1/products/#{product.id}/packages"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
    it 'e acusa erro interno' do
      allow(Product).to receive(:find).and_raise(ActiveRecord::QueryAborted)

      get '/api/v1/products/1/packages'

      expect(response).to have_http_status 500
    end
  end
end
