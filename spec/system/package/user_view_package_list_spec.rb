require 'rails_helper'

describe 'Usuário vê lista de pacotes' do
  it 'com sucesso' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    
    insurance = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number: '01000000123410')
    smartphones = ProductCategory.create!(name: 'Smartphones')
    laptops = ProductCategory.create!(name: 'Laptops')

    service = Service.create!(name: 'Retirada', description: 'Retirada do equipamento para o reparo')

    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: insurance,
                              price: 90.00, product_category: smartphones)
    Package.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: insurance,
                    price: 70.00, product_category: smartphones)
    Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: insurance,
                    price: 150.00, product_category: laptops)
    service_pricing = ServicePricing.create!(percentage_price: 2.00, service: service, package: package)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Pacotes'
    end

    expect(page).to have_content('Categoria')
    expect(page).to have_content('Seguradora')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Período Mínimo')
    expect(page).to have_content('Período Máximo')
    expect(page).to have_content('Preço Mensal')
    expect(page).to have_content('Smartphones')
    expect(page).to have_content('Seguradora')
    expect(page).to have_content('Premium')
    expect(page).to have_content('12 meses')
    expect(page).to have_content('24 meses')
    expect(page).to have_content('R$ 90,00')
    expect(page).to have_content('Smartphones')
    expect(page).to have_content('Seguradora')
    expect(page).to have_content('Econômico')
    expect(page).to have_content('6 meses')
    expect(page).to have_content('18 meses')
    expect(page).to have_content('R$ 70,00')
  end
end
