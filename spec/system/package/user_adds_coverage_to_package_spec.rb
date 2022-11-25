require 'rails_helper'

describe 'Usuário adiciona coberturas a um pacote pendente' do
  it 'com sucesso' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                              product_category: smartphones, status: :pending, price: 0)
    pc1 = PackageCoverage.create!(name: 'Molhar',
                                  description: 'Assistência por danificação devido a molhar o aparelho.')
    PackageCoverage.create!(name: 'Quebra de tela',
                            description: 'Assistência por danificação da tela do aparelho.')
    pc2 = PackageCoverage.create!(name: 'Roubo',
                                  description: 'Assistência em caso de roubo do aparelho.')

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'
    within '#coverage-form' do
      select 'Molhar', from: 'Cobertura'
      fill_in 'Preço Percentual', with: 0.32
      click_on 'Adicionar Cobertura'
      select 'Roubo', from: 'Cobertura'
      fill_in 'Preço Percentual', with: 0.5
      click_on 'Adicionar Cobertura'
    end

    expect(current_path).to eq package_path(package.id)
    expect(page).to have_content 'Cobertura adicionada com sucesso!'
    expect(page).to have_content 'Incluir Cobertura'
    within '#coverage-list' do
      expect(page).to have_content 'Cobertura'
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Código'
      expect(page).to have_content 'Preço Percentual'
      expect(page).to have_content 'Molhar'
      expect(page).to have_content 'Roubo'
      expect(page).to have_content 'Assistência por danificação devido a molhar o aparelho.'
      expect(page).to have_content 'Assistência em caso de roubo do aparelho.'
      expect(page).to have_content pc1.code
      expect(page).to have_content pc2.code
      expect(page).to have_content '0,32%'
      expect(page).to have_content '0,50%'
    end
  end

  it 'incluindo cobertura já adicionada' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                    product_category: smartphones, status: :pending, price: 0)
    PackageCoverage.create!(name: 'Quebra de tela',
                            description: 'Assistência por danificação da tela do aparelho.')

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'
    within '#coverage-form' do
      select 'Quebra de tela', from: 'Cobertura'
      fill_in 'Preço Percentual', with: 0.32
      click_on 'Adicionar Cobertura'
      select 'Quebra de tela', from: 'Cobertura'
      fill_in 'Preço Percentual', with: 0.5
      click_on 'Adicionar Cobertura'
    end

    expect(page).to have_content 'Erro na adição de Cobertura'
  end

  it 'com informações incompletas' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                    product_category: smartphones, status: :pending, price: 0)
    PackageCoverage.create!(name: 'Quebra de tela',
                            description: 'Assistência por danificação da tela do aparelho.', status: :active)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'
    within '#coverage-form-field' do
      fill_in 'Preço Percentual', with: ''
    end
    within '#coverage-form-button' do
      click_on 'Adicionar Cobertura'
    end

    expect(page).to have_content 'Erro na adição de Cobertura'
  end
end

describe 'Usuário visita pagina para criar pacote' do
  it 'e não há coberturas disponíveis' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                    insurance_company: company,
                    product_category: smartphones, status: :pending, price: 0)
    PackageCoverage.create!(name: 'Quebra de tela',
                            description: 'Assistência por danificação da tela do aparelho.', status: :inactive)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'

    expect(page).not_to have_content 'Adionar Cobertura'
    expect(page).to have_content 'Cobertura:'
    expect(page).to have_content 'Não há coberturas ativos'
    expect(page).to have_content 'Preço Percentual (%):'
    expect(page).to have_content 'É preciso adicionar cobertura'
  end

  it 'e só tem acesso a coberturas ativas' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                    insurance_company: company,
                    product_category: smartphones, status: :pending, price: 0)
    PackageCoverage.create!(name: 'Quebra de tela',
                            description: 'Assistência por danificação da tela do aparelho.', status: :inactive)
    PackageCoverage.create!(name: 'Molhar',
                            description: 'Assistência por danificação por humidade', status: :active)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'

    within '#coverage-select' do
      expect(page).not_to have_content 'Quebra de tela'
      expect(page).to have_content 'Molhar'
    end
  end
end
