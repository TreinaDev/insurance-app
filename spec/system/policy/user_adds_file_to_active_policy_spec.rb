require 'rails_helper'

describe 'Funcionário faz upload de arquivo de apólice' do
  it 'com sucesso' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguros', email_domain: 'ligaseguros.com.br',
                                                 registration_number: '84157841000105')
    user = User.create!(email: 'maria@ligaseguros.com.br', password: 'password', name: 'Maria')
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                              price: 9, product_category_id: product_category.id)
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

    policy.active!

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Ativas'
    find(:css, '#active-tab-pane').click_on policy.code
    attach_file 'Contrato de seguro', Rails.root.join('spec/support/policy_files/sample-policy-a.pdf')
    click_on 'Enviar'

    expect(page).to have_content('Upload feito com sucesso')
    expect(page).to have_content("Data da Contratação: #{Time.zone.today.strftime('%d/%m/%Y')}")
    expect(page).to have_content('Apólice: Download')
    expect(policy.file.attached?).to be true
  end
end
