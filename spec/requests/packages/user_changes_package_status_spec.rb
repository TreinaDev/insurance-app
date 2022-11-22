require 'rails_helper'

describe 'Usuário altera o status de um pacote' do
  context 'para ativo' do
    it 'e não está autenticado' do
      company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                         registration_number: '80958759000110')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                                product_category: smartphones, status: :pending)
      coverage1 = PackageCoverage.create!(name: 'Molhar',
                                          description: 'Assistência por danificação devido a molhar o aparelho.')
      CoveragePricing.create!(percentage_price: 0.30, package:, package_coverage: coverage1)
      service1 = Service.create!(name: 'Desconto Petlove',
                                 description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.',
                                 status: :active)
      ServicePricing.create!(percentage_price: 0.15, package:, service: service1)

      post(activate_package_path(package.id))

      expect(response).to redirect_to(new_user_session_url)
    end

    it 'como funcionário de outra seguradora' do
      InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                               registration_number: '80958759000110')
      company2 = InsuranceCompany.create!(name: 'Azul', email_domain: 'azul.com.br',
                                          registration_number: '12358759000110')
      user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company2,
                                product_category: smartphones, status: :pending)
      coverage1 = PackageCoverage.create!(name: 'Molhar',
                                          description: 'Assistência por danificação devido a molhar o aparelho.')
      CoveragePricing.create!(percentage_price: 0.30, package:, package_coverage: coverage1)
      service1 = Service.create!(name: 'Desconto Petlove',
                                 description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.',
                                 status: :active)
      ServicePricing.create!(percentage_price: 0.15, package:, service: service1)

      login_as(user)
      post(activate_package_path(package.id))

      expect(response).to redirect_to(root_path)
    end
    it 'como administrador' do
      company1 = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                          registration_number: '80958759000110')
      admin = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :admin)
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company1,
                                product_category: smartphones, status: :pending)
      coverage1 = PackageCoverage.create!(name: 'Molhar',
                                          description: 'Assistência por danificação devido a molhar o aparelho.')
      CoveragePricing.create!(percentage_price: 0.30, package:, package_coverage: coverage1)
      service1 = Service.create!(name: 'Desconto Petlove',
                                 description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.',
                                 status: :active)
      ServicePricing.create!(percentage_price: 0.15, package:, service: service1)

      login_as(admin)
      post(activate_package_path(package.id))

      expect(response).to redirect_to(root_path)
    end
  end
end
