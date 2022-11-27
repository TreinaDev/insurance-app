require 'rails_helper'

describe 'Administrador vê detalhes de apólice ativa' do
  it 'com sucesso' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                 registration_number: '84157841000105')
    user = User.create!(email: 'maria@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                              insurance_company_id: insurance_company.id, price: 9,
                              product_category_id: product_category.id)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')
    policy = Policy.create(client_name: 'Mariana Souza', client_registration_number: '03324431940',
                           client_email: 'mari@gmail.com',
                           insurance_company_id: insurance_company.id, order_id: 1,
                           equipment_id: 1,
                           policy_period: 18, package_id: package.id, status: :active)
    json = Rails.root.join('spec/support/jsons/order.json').read
    fake_response = double('faraday_response', status: 200, body: json, success?: true)
    allow(Faraday).to receive(:get)
      .with("#{Rails.configuration.external_apis['comparator_api']}/orders/#{policy.order_id}")
      .and_return(fake_response)

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Todas'
    find(:css, '#all-tab-pane').click_on 'ABC1234567'

    expect(page).to have_content 'Apólice: ABC1234567'
    expect(page).to have_content 'Situação da Apólice: Ativa'
    expect(page).to have_content 'Nome do Cliente: Mariana Souza'
    expect(page).to have_content 'CPF do Cliente: 03324431940'
    expect(page).to have_content 'E-mail do Cliente: mari@gmail.com'
    expect(page).to have_content 'Seguradora: Liga Seguradora'
    expect(page).to have_content 'Pacote: Premium'
    expect(page).to have_content 'Data da Contratação:'
    expect(page).to have_content Time.zone.today.strftime('%d/%m/%Y')
    expect(page).to have_content 'Prazo de Contratação: 18 meses'
    expect(page).to have_content (Time.zone.today + 18.months).strftime('%d/%m/%Y')
    expect(page).to have_content 'Preço final: R$ 3060,00'
    expect(page).to have_content 'Preço por mês: R$ 170,00'
    expect(page).to have_content 'Aparelho: Xiaomi RedNote 10'
    expect(page).to have_content 'Desconto de promoção: R$ 306,00'
    expect(page).to have_content 'Data de compra do aparelho: 15/12/2020'
  end
end

describe 'Funcionário vê detalhes de apólice pendente de sua seguradora' do
  it 'com sucesso' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                 registration_number: '84157841000105')
    user = User.create!(email: 'maria@ligaseguradora.com.br', password: 'password', name: 'Maria')
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                              insurance_company_id: insurance_company.id, price: 9,
                              product_category_id: product_category.id)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')
    policy = Policy.create(client_name: 'Mariana Souza', client_registration_number: '03324431940',
                           client_email: 'mari@gmail.com',
                           insurance_company_id: insurance_company.id, order_id: 1,
                           equipment_id: 1,
                           policy_period: 18, package_id: package.id, status: :pending)
    json = Rails.root.join('spec/support/jsons/order.json').read
    fake_response = double('faraday_response', status: 200, body: json, success?: true)
    allow(Faraday).to receive(:get)
      .with("#{Rails.configuration.external_apis['comparator_api']}/orders/#{policy.order_id}")
      .and_return(fake_response)

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Pendentes'
    find(:css, '#all-tab-pane').click_on 'ABC1234567'

    expect(page).to have_content 'Apólice: ABC1234567'
    expect(page).to have_content 'Situação da Apólice: Pendente'
    expect(page).to have_content 'Nome do Cliente: Mariana Souza'
    expect(page).to have_content 'CPF do Cliente: 03324431940'
    expect(page).to have_content 'E-mail do Cliente: mari@gmail.com'
    expect(page).to have_content 'Seguradora: Liga Seguradora'
    expect(page).to have_content 'Pacote: Premium'
  end
end
