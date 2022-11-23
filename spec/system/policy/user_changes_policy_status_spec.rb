require 'rails_helper'

describe 'Usuário altera status da apólice' do
  context 'como funcionário' do
    it 'para cancelado' do
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

      login_as(user)
      visit root_path
      click_on 'Apólices'
      click_on 'Pendentes'
      find(:css, '#pending-tab-pane').click_on 'GHI1234567'
      click_on 'Reprovar'

      expect(page).to have_content 'Apólice reprovada'
      expect(page).to have_content 'Situação da Apólice: Cancelada'
    end
  end

  context 'como administrador' do
    it 'e não vê botão de alterar status' do
      user = User.create!(email: 'maria@ligaseguradora.com.br', password: 'password', name: 'Maria', role: :admin)
      insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                   registration_number: '84157841000105')
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

      login_as(user)
      visit root_path
      click_on 'Apólices'
      click_on 'Pendentes'
      find(:css, '#pending-tab-pane').click_on 'GHI1234567'

      expect(page).not_to have_content 'Aprovar'
      expect(page).not_to have_content 'Reprovar'
      expect(page).to have_content 'Apólice: GHI1234567'
    end
  end
end

describe 'Usuário de seguradora visita lista de apólices' do
  it 'E só vê apólices de sua seguradora' do
    insurance_company1 = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                  registration_number: '00057841000105')
    insurance_company2 = InsuranceCompany.create!(name: 'Anjo Seguradora', email_domain: 'anjoseguradora.com.br',
                                                  registration_number: '84157841000105')
    user = User.create!(email: 'maria@ligaseguradora.com.br', password: 'password', name: 'Maria')

    product_category = ProductCategory.create!(name: 'TV')

    package1 = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                               insurance_company_id: insurance_company1.id,
                               price: 90.00, product_category_id: product_category.id)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GHI1234567')
    Policy.create(client_name: 'Maria Alves', client_registration_number: '99950033340',
                  client_email: 'mariaalves@email.com',
                  insurance_company_id: insurance_company1.id, order_id: 1,
                  equipment_id: 1, purchase_date: Time.zone.today,
                  policy_period: 12, package_id: package1.id, status: :pending)

    package2 = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                               insurance_company_id: insurance_company2.id,
                               price: 90.00, product_category_id: product_category.id)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')
    Policy.create(client_name: 'Bianca Lima', client_registration_number: '55550033340',
                  client_email: 'biancalima@email.com',
                  insurance_company_id: insurance_company2.id, order_id: 2,
                  equipment_id: 1, purchase_date: Time.zone.today,
                  policy_period: 12, package_id: package2.id, status: :pending)

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Todas'

    expect(page).to have_content 'GHI1234567'
    expect(page).not_to have_content 'ABC1234567'
  end
end

describe '.approve_order' do
  it 'POST aprovação da seguradora para o comparador de seguros' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguros', email_domain: 'ligaseguros.com.br',
                                                 registration_number: '84157841000105')
    user = User.create!(email: 'maria@ligaseguros.com.br', password: 'password', name: 'Maria')
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                              price: 90.00, product_category_id: product_category.id)
    policy = Policy.create!(client_name: 'José Antonio', client_registration_number: '77750033340',
                            client_email: 'joseantonio@email.com',
                            insurance_company_id: insurance_company.id, order_id: 1,
                            equipment_id: 1, purchase_date: '2022-11-12',
                            policy_period: 12, package_id: package.id)
    url = "http://localhost:4000/api/v1/orders/#{policy.order_id}/insurance_approved"
    json_data = { "order": { "status": ":insurance_approved", "policy_id": "#{policy.id}", "policy_code": "#{policy.code}" } }
    fake_response = double("faraday_response", status: 200)
    
    allow(Faraday).to receive(:post).with(url, body: json_data).and_return(fake_response)
    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Pendentes'
    find(:css, '#pending-tab-pane').click_on policy.code
    click_on 'Aprovar'
    click_on 'Apólices'
    click_on 'Pagamento Pendente'
    find(:css, '#pending-payment-tab-pane').click_on policy.code

    expect(page).to have_content 'E-mail do Cliente: joseantonio@email.com'
    expect(page).to have_content "#{policy.code}"
    expect(page).to have_content 'Situação da Apólice: Pagamento Pendente'
  end
end
