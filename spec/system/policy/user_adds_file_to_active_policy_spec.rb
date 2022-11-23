require 'rails_helper'

describe 'Funcionário faz upload de arquivo de apólice' do
  it 'com sucesso' do
    insurance_company = InsuranceCompany.create!(name: 'Liga Seguros', email_domain: 'ligaseguros.com.br',
                                                 registration_number: '84157841000105')
    user = User.create!(email: 'maria@ligaseguros.com.br', password: 'password', name: 'Maria')
    product_category = ProductCategory.create!(name: 'TV')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                              price: 9, product_category_id: product_category.id)
    policy = Policy.create!(client_name: 'José Antonio', client_registration_number: '77750033340',
                            client_email: 'joseantonio@email.com',
                            insurance_company_id: insurance_company.id, order_id: 1,
                            equipment_id: 1,
                            policy_period: 12, package_id: package.id)
    policy.active!

    login_as(user)
    visit root_path
    click_on 'Apólices'
    click_on 'Ativas'
    find(:css, '#active-tab-pane').click_on policy.code
    attach_file 'Arquivo', Rails.root.join('spec/support/policy_files/sample-policy-a.pdf')
    click_on 'Enviar'

    expect(page).to have_content('Upload feito com sucesso')
    expect(page).to have_content("Data da Contratação: #{Time.zone.today.strftime('%d/%m/%Y')}")
    expect(page).to have_content('Apólice: Download')
    expect(policy.file.attached?).to be true
  end
end
