require 'rails_helper'

describe 'Administrador vê lista de apólices com pagamento pendente' do
  it 'com sucesso' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                 registration_number: '84157841000105')
    user = User.create!(email: 'maria@ligaseguradora.com.br', password: 'password', name: 'Maria', role: :admin)
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                              insurance_company_id: insurance_company.id,
                              price: 90.00, product_category_id: product_category.id)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')
    Policy.create(client_name: 'Maria Alves', client_registration_number: '99950033340',
                  client_email: 'mariaalves@email.com',
                  insurance_company_id: insurance_company.id, order_id: 1,
                  equipment_id: 1,
                  policy_period: 12, package_id: package.id, status: :pending_payment)

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Pagamento Pendente'

    expect(page).to have_content 'Código da Apólice'
    expect(page).to have_content 'Nome do Cliente'
    expect(page).to have_content 'Data da Contratação'
    expect(page).to have_content 'ABC1234567'
    expect(page).to have_content 'Maria Alves'
  end
  it 'e não há apólices pendentes de pagamento cadastradas' do
    InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                             registration_number: '84157841000105')
    user = User.create!(email: 'maria@ligaseguradora.com.br', password: 'password', name: 'Maria', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Pagamento Pendente'

    expect(page).to have_content 'Não existem apólices com pagamento pendente'
  end
end

describe 'Funcionário vê lista de apólices com pagamento pendente' do
  it 'com sucesso' do
    insurance_company1 = InsuranceCompany.create!(name: 'Anjo Seguradora', email_domain: 'anjoseguradora.com.br',
                                                  registration_number: '84157841000105')
    insurance_company2 = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                  registration_number: '55557841000105')
    user = User.create!(email: 'maria@ligaseguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    product_category = ProductCategory.create!(name: 'TV')

    package1 = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                               insurance_company_id: insurance_company1.id,
                               price: 90.00, product_category_id: product_category.id)
    package2 = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                               insurance_company_id: insurance_company2.id,
                               price: 90.00, product_category_id: product_category.id)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')
    Policy.create(client_name: 'Maria Alves', client_registration_number: '99950033340',
                  client_email: 'mariaalves@email.com',
                  insurance_company_id: insurance_company1.id, order_id: 1,
                  equipment_id: 1,
                  policy_period: 12, package_id: package1.id, status: :active)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('DEF1234567')
    Policy.create(client_name: 'Renato Alves', client_registration_number: '00050033340',
                  client_email: 'renatoalves@email.com',
                  insurance_company_id: insurance_company2.id, order_id: 2,
                  equipment_id: 1,
                  policy_period: 12, package_id: package2.id, status: :pending_payment)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GHI1234567')
    Policy.create(client_name: 'Pedro Dias', client_registration_number: '11150033340',
                  client_email: 'pedrodias@email.com',
                  insurance_company_id: insurance_company2.id, order_id: 3,
                  equipment_id: 1,
                  policy_period: 12, package_id: package2.id, status: :pending_payment)

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Pagamento Pendente'

    expect(page).to have_content 'Código da Apólice'
    expect(page).to have_content 'Nome do Cliente'
    expect(page).to have_content 'Data da Contratação'
    expect(page).to have_content 'Renato Alves'
    expect(page).to have_content 'DEF1234567'
    expect(page).to have_content 'Pedro Dias'
    expect(page).to have_content 'GHI1234567'
  end
  it 'e não há apólices pendentes de pagamento cadastradas' do
    insurance_company1 = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                  registration_number: '84157841000105')
    insurance_company2 = InsuranceCompany.create!(name: 'Anjo Seguradora', email_domain: 'anjoseguradora.com.br',
                                                  registration_number: '00057841000105')
    user = User.create!(email: 'maria@anjoseguradora.com.br', password: 'password', name: 'Maria')
    product_category = ProductCategory.create!(name: 'TV')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company_id:
                    insurance_company1.id,
                    price: 90.00, product_category_id: product_category.id)
    Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                    insurance_company_id: insurance_company2.id,
                    price: 90.00, product_category_id: product_category.id)

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Pagamento Pendente'

    expect(page).to have_content 'Não existem apólices cadastradas'
  end
end
