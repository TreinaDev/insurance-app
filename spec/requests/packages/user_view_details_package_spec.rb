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
end
