require 'rails_helper'

describe 'Usuário vê página de detalhes do pacote' do
  it 'como funcionário com sucesso' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                    product_category: smartphones)
    Package.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: company,
                    product_category: smartphones)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'

    expect(page).to have_content('Pacote Premium')
    expect(page).to have_content('Seguradora: Seguradora Exemplo')
    expect(page).to have_content('Categoria: Smartphones')
    expect(page).to have_content('Período Mínimo: 12 meses')
    expect(page).to have_content('Período Máximo: 24 meses')
    expect(page).to have_content('Pendente')
  end

  it 'como administrador com sucesso' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    admin = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                    product_category: smartphones)
    Package.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: company,
                    product_category: smartphones)

    login_as(admin)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'

    expect(page).to have_content('Pacote Premium')
    expect(page).to have_content('Seguradora: Seguradora Exemplo')
    expect(page).to have_content('Categoria: Smartphones')
    expect(page).to have_content('Período Mínimo: 12 meses')
    expect(page).to have_content('Período Máximo: 24 meses')
    expect(page).to have_content('Pendente')
  end

  it 'e não está autenticado' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    smartphones = ProductCategory.create!(name: 'Smartphones')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                              product_category: smartphones)

    visit package_path(package.id)

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
    expect(current_path).to eq user_session_path
  end

  it 'como funcionário de outra seguradora' do
    InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                             registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradoraa.com.br', password: 'password', name: 'Maria', role: :employee)
    company = InsuranceCompany.create!(name: 'Azul', email_domain: 'azul.com.br',
                                       registration_number: '12358759000110')
    smartphones = ProductCategory.create!(name: 'Smartphones')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                              product_category: smartphones)

    login_as(user)
    visit package_path(package.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Pacote indisponível'
  end
end
