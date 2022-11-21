require 'rails_helper'

RSpec.describe 'Usuário visualiza detalhe de apólice', type: :request do
  it 'e não está logado' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                 registration_number: '84157841000105')
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                              insurance_company:, price: 90.00, product_category_id: product_category.id)
    policy = Policy.create(client_name: 'Maria Alves', client_registration_number: '99950033340',
                           client_email: 'mariaalves@email.com',
                           insurance_company_id: insurance_company.id, order_id: 1,
                           equipment_id: 1,
                           policy_period: 12, package_id: package.id, status: :active)

    get "/policies/#{policy.id}"

    expect(response).to redirect_to(user_session_path)
  end
end

RSpec.describe 'Usuário visualiza lista de apólices', type: :request do
  it 'e não está logado' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                 registration_number: '84157841000105')
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                              insurance_company:, price: 90.00, product_category_id: product_category.id)
    Policy.create(client_name: 'Maria Alves', client_registration_number: '99950033340',
                  client_email: 'mariaalves@email.com',
                  insurance_company_id: insurance_company.id, order_id: 1,
                  equipment_id: 1,
                  policy_period: 12, package_id: package.id, status: :active)

    get '/policies'

    expect(response).to redirect_to(user_session_path)
  end
end
