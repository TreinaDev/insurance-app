require 'rails_helper'

describe 'Find Package for Product API' do
  context 'GET api/v1/products/1/packages/1' do
    it 'com sucesso' do
      insurance_company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                   registration_number: '00000000000000')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      product = Product.create!(product_model: 'iPhone 13 Pro', launch_year: '2021',
                                brand: 'Apple', price: 5000, product_category: smartphones)
      package_a = Package.create!(name: 'Econômico', min_period: 12, max_period: 24, insurance_company:,
                                  product_category: smartphones, status: :active, price: 0.20)
      package_b = Package.create!(name: 'Premium', min_period: 6, max_period: 18, insurance_company:,
                                  product_category: smartphones, status: :active, price: 0.46)
      coverage = PackageCoverage.create!(name: 'Molhar',
                                         description: 'Assistência por danificação devido a molhar o aparelho.')
      CoveragePricing.create!(percentage_price: 0.20, package: package_a, package_coverage: coverage)
      CoveragePricing.create!(percentage_price: 0.30, package: package_b, package_coverage: coverage)
      s1 = Service.create!(name: 'Assinatura TV',
                           description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
      ServicePricing.create!(percentage_price: 0.05, package: package_a, service: s1)
      ServicePricing.create!(percentage_price: 0.16, package: package_b, service: s1)

      get "/api/v1/products/#{product.id}/packages/#{package_b.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'Premium'
      expect(json_response['max_period']).to eq 18
      expect(json_response['min_period']).to eq 6
      expect(json_response['insurance_company_id']).to eq insurance_company.id
      expect(json_response['insurance_company_name']).to eq 'Seguradora A'
      expect(json_response['product_category_id']).to eq smartphones.id
      expect(json_response['price_per_month']).to eq '23.0'
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
      expect(json_response.keys).not_to include('status')
    end

    it 'falha se o pacote não é encontrado' do
      smartphones = ProductCategory.create!(name: 'Smartphones')
      product = Product.create!(product_model: 'iPhone 13 Pro', launch_year: '2021',
                                brand: 'Apple', price: 5000, product_category: smartphones)
      get "/api/v1/products/#{product.id}/packages/9999999"

      expect(response.status).to eq 404
    end

    it 'falha se o produto não é encontrado' do
      insurance_company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                   registration_number: '00000000000000')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package_a = Package.create!(name: 'Econômico', min_period: 12, max_period: 24, insurance_company:,
                                  product_category: smartphones, status: :active, price: 0.20)
      coverage = PackageCoverage.create!(name: 'Molhar',
                                         description: 'Assistência por danificação devido a molhar o aparelho.')
      CoveragePricing.create!(percentage_price: 0.20, package: package_a, package_coverage: coverage)

      get "/api/v1/products/999/packages/#{package_a.id}"

      expect(response.status).to eq 404
    end

    it 'falha se não existe pacote para o produto' do
      insurance_company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                   registration_number: '00000000000000')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      tvs = ProductCategory.create!(name: 'TVs')
      product = Product.create!(product_model: 'iPhone 13 Pro', launch_year: '2021',
                                brand: 'Apple', price: 5000, product_category: smartphones)
      package_a = Package.create!(name: 'Econômico', min_period: 12, max_period: 24, insurance_company:,
                                  product_category: tvs, status: :active, price: 0.20)
      coverage = PackageCoverage.create!(name: 'Molhar',
                                         description: 'Assistência por danificação devido a molhar o aparelho.')
      CoveragePricing.create!(percentage_price: 0.20, package: package_a, package_coverage: coverage)

      get "/api/v1/products/#{product.id}/packages/#{package_a.id}"

      expect(response.status).to eq 404
    end
  end
end
