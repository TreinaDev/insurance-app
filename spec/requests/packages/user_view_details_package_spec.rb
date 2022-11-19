require 'rails_helper'

describe 'Usuário visualiza pacotes' do
  it 'e não está autenticado' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    smartphones = ProductCategory.create!(name: 'Smartphones')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                              product_category: smartphones)

    get(package_path(package.id))

    expect(response).to redirect_to(user_session_path)
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
    get(package_path(package.id))

    expect(response).to redirect_to(root_path)
  end
end
