require 'rails_helper'

describe 'Usuário ativa um pacote pendente' do
  context 'como funcionário' do
    it 'com sucesso' do
      company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                         registration_number: '80958759000110')
      user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
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

      login_as(user)
      visit root_path
      click_on 'Pacotes'
      click_on 'Premium'
      click_on 'Ativar Pacote'

      expect(page).to have_content 'Pacote ativado com sucesso!'
      expect(page).to have_content 'Ativo'
      expect(page).to have_content 'Preço Percentual: 0,45% a.m.'
      within '#coverage-list' do
        expect(page).to have_content 'Cobertura'
        expect(page).to have_content 'Descrição'
        expect(page).to have_content 'Código'
        expect(page).to have_content 'Preço Percentual'
        expect(page).to have_content 'Molhar'
        expect(page).to have_content 'Assistência por danificação devido a molhar o aparelho.'
        expect(page).to have_content coverage1.code
        expect(page).to have_content '0,30%'
      end
      within '#service-list' do
        expect(page).to have_content 'Serviço'
        expect(page).to have_content 'Descrição'
        expect(page).to have_content 'Código'
        expect(page).to have_content 'Preço Percentual'
        expect(page).to have_content 'Desconto Petlove'
        expect(page).to have_content 'Concede 10% de desconto em aquisição de produtos na loja Petlove.'
        expect(page).to have_content service1.code
        expect(page).to have_content '0,15%'
      end
      expect(page).not_to have_content 'Pendente'
      expect(page).not_to have_content 'Incluir Cobertura'
      expect(page).not_to have_content 'Incluir Serviço'
    end

    it 'sem adicionar coberturas' do
      company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                         registration_number: '80958759000110')
      user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                                product_category: smartphones, status: :pending)
      service1 = Service.create!(name: 'Desconto Petlove',
                                 description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.',
                                 status: :active)
      ServicePricing.create!(percentage_price: 0.15, package:, service: service1)

      login_as(user)
      visit root_path
      click_on 'Pacotes'
      click_on 'Premium'

      expect(page).not_to have_content 'Ativar Pacote'
    end
  end

  it 'como administrador' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    admin = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
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

    login_as(admin)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'

    within '#coverage-list' do
      expect(page).to have_content 'Cobertura'
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Código'
      expect(page).to have_content 'Preço Percentual'
      expect(page).to have_content 'Molhar'
      expect(page).to have_content 'Assistência por danificação devido a molhar o aparelho.'
      expect(page).to have_content coverage1.code
      expect(page).to have_content '0,30%'
    end
    within '#service-list' do
      expect(page).to have_content 'Serviço'
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Código'
      expect(page).to have_content 'Preço Percentual'
      expect(page).to have_content 'Desconto Petlove'
      expect(page).to have_content 'Concede 10% de desconto em aquisição de produtos na loja Petlove.'
      expect(page).to have_content service1.code
      expect(page).to have_content '0,15%'
    end
    expect(page).not_to have_content 'Incluir Cobertura'
    expect(page).not_to have_content 'Incluir Serviço'
    expect(page).not_to have_field 'Cobertura'
    expect(page).not_to have_field 'Serviço'
    expect(page).not_to have_field 'Preço Percentual'
    expect(page).not_to have_content 'Adicionar Cobertura'
    expect(page).not_to have_content 'Adicionar Serviço'
    expect(page).not_to have_content 'Ativar Pacote'
  end
end
