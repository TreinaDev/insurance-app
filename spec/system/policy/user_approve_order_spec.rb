require 'rails_helper'

describe 'Funcionário de Seguradora aprova Pedido' do
  it 'com sucesso' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                  registration_number: '84157841000105')
    user = User.create!(email: 'maria@ligaseguradora.com.br', password: 'password', name: 'Maria')
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                              insurance_company_id: insurance_company.id,
                              price: 90.00, product_category_id: product_category.id)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GHI1234567')
    Policy.create(client_name: 'Maria Alves', client_registration_number: '99950033340',
                  client_email: 'mariaalves@email.com',
                  insurance_company_id: insurance_company.id, order_id: 1,
                  equipment_id: 1, purchase_date: Time.zone.today,
                  policy_period: 12, package_id: package.id, status: :pending)
    url = 'localhost:4000/orders/1/approved'
    response = double('faraday_response', status: 200)
    allow(Faraday).to receive(:post).with(url).and_return(response)

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Pendentes'
    find(:css, '#pending-tab-pane').click_on 'GHI1234567'
    click_on 'Aprovar'

    expect(response).to have_http_status 200
    expect(page).to have_content 'Aprovação efetuada com sucesso'
  end
end




