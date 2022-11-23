require 'rails_helper'

describe 'Product API' do
  context 'GET /api/v1/products' do
    it 'lista todos os produtos ordeandos pelo nome' do
      product_category = ProductCategory.create!(name: 'TV')
      producta = Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG',
                                 price: 5000, product_category_id: product_category.id)
      Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'SAMSUNG',
                      price: 8000, product_category_id: product_category.id)
      image_path = Rails.root.join('spec/support/images/tv32.jpeg')
      producta.image.attach(io: image_path.open, filename: 'tv32.jpeg')

      get '/api/v1/products'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['product_model']).to eq 'TV 32'
      expect(json_response[1]['product_model']).to eq 'TV 50'
      expect(json_response[0].keys).to include('image_url')
    end

    it 'retorna vazio se não houver produtos' do
      get '/api/v1/products'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'e acusa erro interno' do
      allow(Product).to receive(:all).and_raise(ActiveRecord::QueryAborted)

      get '/api/v1/products'

      expect(response).to have_http_status 500
    end
  end

  context 'GET /api/v1/products/1' do
    it 'sucesso' do
      product_category = ProductCategory.create!(name: 'TV')
      product = Product.create!(product_model: 'TV 32', launch_year: '2022',
                                brand: 'LG', price: 5000, product_category_id: product_category.id)
      image_path = Rails.root.join('spec/support/images/tv32.jpeg')
      product.image.attach(io: image_path.open, filename: 'tv32.jpeg')

      get "/api/v1/products/#{product.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['product_model']).to eq('TV 32')
      expect(json_response['launch_year']).to eq('2022')
      expect(json_response['brand']).to eq('LG')
      expect(json_response['price']).to eq '5000.0'
      expect(json_response.keys).to include('image_url')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'falha se o produto não for encontrado' do
      get '/api/v1/products/3333'

      expect(response.status).to eq 404
    end
  end

  context 'GET api/v1/products/1/packages' do
    it 'com sucesso' do
      insurance_company_a = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '00000000000000')
      insurance_company_b = InsuranceCompany.create!(name: 'Seguradora B', email_domain: 'seguradorab.com.br',
                                                     registration_number: '00000000000001')

      smartphones = ProductCategory.create!(name: 'Smartphones')
      tvs = ProductCategory.create!(name: 'Televisões')
      product = Product.create!(product_model: 'iPhone 13 Pro', launch_year: '2021',
                                brand: 'Apple', price: 5000, product_category: smartphones)

      coverage1 = PackageCoverage.create!(name: 'Molhar',
                                          description: 'Assistência por danificação devido a molhar o aparelho.')
      coverage2 = PackageCoverage.create!(name: 'Quebra de tela',
                                          description: 'Assistência por danificação da tela do aparelho.')
      service1 = Service.create!(name: 'Desconto Petlove',
                                 description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.')
      service2 = Service.create!(name: 'Assinatura TV',
                                 description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')

      package_a = Package.create!(name: 'Econômico', min_period: 12, max_period: 24, insurance_company: insurance_company_a,
                                  product_category: smartphones, status: :active, price: 1.04)
      CoveragePricing.create!(percentage_price: 0.30, package: package_a, package_coverage: coverage1)
      ServicePricing.create!(percentage_price: 0.16, package: package_a, service: service1)
      CoveragePricing.create!(percentage_price: 0.41, package: package_a, package_coverage: coverage2)
      ServicePricing.create!(percentage_price: 0.17, package: package_a, service: service2)
      
      package_b = Package.create!(name: 'Premium', min_period: 6, max_period: 18, insurance_company: insurance_company_b,
                                  product_category: smartphones, status: :active, price: 1.22)
      CoveragePricing.create!(percentage_price: 0.50, package: package_b, package_coverage: coverage1)
      ServicePricing.create!(percentage_price: 0.15, package: package_b, service: service1)
      CoveragePricing.create!(percentage_price: 0.45, package: package_b, package_coverage: coverage2)
      ServicePricing.create!(percentage_price: 0.12, package: package_b, service: service2)

      Package.create!(name: 'Master', max_period: 10, min_period: 5, insurance_company: insurance_company_b,
                      product_category: tvs, status: :active, price: 0.7)

      Package.create!(name: 'Max', max_period: 20, min_period: 9, insurance_company: insurance_company_a,
                      product_category: smartphones, status: :pending)

      Package.create!(name: 'Super', max_period: 12, min_period: 6, insurance_company: insurance_company_b,
                      product_category: smartphones, status: :inactive)

      get "/api/v1/products/#{product.id}/packages"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Econômico'
      expect(json_response[0]['max_period']).to eq 24
      expect(json_response[0]['min_period']).to eq 12
      expect(json_response[0]['insurance_company_id']).to eq insurance_company_a.id
      expect(json_response[0]['product_category_id']).to eq smartphones.id
      expect(json_response[0]['coverages'].length).to eq 2
      expect(json_response[0]['coverages'][0]).to eq coverage1.id
      expect(json_response[0]['coverages'][1]).to eq coverage2.id
      expect(json_response[0]['services'].length).to eq 2
      expect(json_response[0]['services'][0]).to eq service1.id
      expect(json_response[0]['services'][1]).to eq service2.id
      expect(json_response[0]['price_per_month']).to eq '52.0'
      expect(json_response[0].keys).not_to include('created_at')
      expect(json_response[0].keys).not_to include('updated_at')
      expect(json_response[0].keys).not_to include('status')

      expect(json_response[1]['name']).to eq 'Premium'
      expect(json_response[1]['max_period']).to eq 18
      expect(json_response[1]['min_period']).to eq 6
      expect(json_response[1]['insurance_company_id']).to eq insurance_company_b.id
      expect(json_response[1]['product_category_id']).to eq smartphones.id
      expect(json_response[1]['coverages'].length).to eq 2
      expect(json_response[1]['coverages'][0]).to eq coverage1.id
      expect(json_response[1]['coverages'][1]).to eq coverage2.id
      expect(json_response[1]['services'].length).to eq 2
      expect(json_response[1]['services'][0]).to eq service1.id
      expect(json_response[1]['services'][1]).to eq service2.id
      expect(json_response[1]['price_per_month']).to eq '61.0'
      expect(json_response[1].keys).not_to include('created_at')
      expect(json_response[1].keys).not_to include('updated_at')
      expect(json_response[1].keys).not_to include('status')
    end
  end
end
