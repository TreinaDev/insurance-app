require 'rails_helper'

describe 'Usuário tenta registra um pacote' do
  it 'e não está autenticado' do
    company = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                        '80958759000110')
    category = ProductCategory.create!(name: 'Smartphones')

    post(packages_path, params: { package: { name: 'PremiumPlatinum', min_period: 12, max_period: 24, insurance_company:
                                            company, product_category: category } })

    expect(response).to redirect_to(user_session_path)
    expect(Package.all.length).to eq(0)
  end
end
