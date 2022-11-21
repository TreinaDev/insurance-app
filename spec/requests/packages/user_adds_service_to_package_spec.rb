require 'rails_helper'

describe 'Usuário adicionar um serviço a um pacote' do
  it 'e não está autenticado' do
    company = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    category = ProductCategory.create!(name: 'Smartphones')
    package =  Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                               product_category: category, status: :pending)
    service = Service.create!(name: 'Desconto Petlove',
                              description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.',
                              status: :active)

    post(package_service_pricings_path(package.id), params: { service_pricing: { percentage_price: 0.15,
                                                                                 package:,
                                                                                 service: } })

    expect(response).to redirect_to(user_session_path)
    expect(package.service_pricings.length).to eq(0)
  end
end
