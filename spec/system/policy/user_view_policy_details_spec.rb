require 'rails_helper'

describe 'Administrador vê detalhes de apólice ativa' do
  it 'com sucesso' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                 registration_number: '84157841000105')
    user = User.create!(email: 'maria@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                              insurance_company_id: insurance_company.id, price: 90.00,
                              product_category_id: product_category.id)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')
    Policy.create(client_name: 'Maria Alves', client_registration_number: '99950033340',
                  client_email: 'mariaalves@email.com',
                  insurance_company_id: insurance_company.id, order_id: 1,
                  equipment_id: 1, purchase_date: Time.zone.today,
                  policy_period: 12, package_id: package.id, status: :active)

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Todas'
    find(:css, '#all-tab-pane').click_on 'ABC1234567'

    expect(page).to have_content 'Apólice: ABC1234567'
    expect(page).to have_content 'Situação da Apólice: Ativo'
    expect(page).to have_content 'Nome do Cliente: Maria Alves'
    expect(page).to have_content 'CPF do Cliente: 99950033340'
    expect(page).to have_content 'E-mail do Cliente: mariaalves@email.com'
    expect(page).to have_content 'Seguradora: Liga Seguradora'
    expect(page).to have_content 'Pacote: Premium'
    expect(page).to have_content 'Data da Contratação:'
    expect(page).to have_content Time.zone.today.strftime('%d/%m/%Y')
    expect(page).to have_content 'Prazo de Contratação: 12 meses'
    expect(page).to have_content (Time.zone.today + 12.months).strftime('%d/%m/%Y')
  end
end

describe 'Funcionário vê detalhes de apólice pendente de sua seguradora' do
  it 'com sucesso' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                 registration_number: '84157841000105')
    user = User.create!(email: 'maria@ligaseguradora.com.br', password: 'password', name: 'Maria')
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                              insurance_company_id: insurance_company.id, price: 90.00,
                              product_category_id: product_category.id)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')
    Policy.create(client_name: 'Maria Alves', client_registration_number: '99950033340',
                  client_email: 'mariaalves@email.com',
                  insurance_company_id: insurance_company.id, order_id: 1,
                  equipment_id: 1, purchase_date: Time.zone.today,
                  policy_period: 12, package_id: package.id, status: :pending)

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Pendentes'
    find(:css, '#all-tab-pane').click_on 'ABC1234567'

    expect(page).to have_content 'Apólice: ABC1234567'
    expect(page).to have_content 'Situação da Apólice: Pendente'
    expect(page).to have_content 'Nome do Cliente: Maria Alves'
    expect(page).to have_content 'CPF do Cliente: 99950033340'
    expect(page).to have_content 'E-mail do Cliente: mariaalves@email.com'
    expect(page).to have_content 'Seguradora: Liga Seguradora'
    expect(page).to have_content 'Pacote: Premium'
    expect(page).to have_content 'Data da Contratação:'
    expect(page).to have_content Time.zone.today.strftime('%d/%m/%Y')
    expect(page).to have_content 'Prazo de Contratação: 12 meses'
    expect(page).to have_content (Time.zone.today + 12.months).strftime('%d/%m/%Y')
  end
end
