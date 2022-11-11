require 'rails_helper'

describe 'Usuário vê lista de pacotes' do
  it 'com sucesso e é administrador' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password',
                        role: :admin)
    insurance = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                        '01000000123410')
    smartphones = ProductCategory.create!(name: 'Smartphones')
    PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: insurance,
                          product_category: smartphones)
    PendingPackage.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: insurance,
                          product_category: smartphones)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Pacotes Pendetes'
    end

    expect(page).to have_content('Lista de Pacotes Pendentes')
    expect(page).to have_content('Categoria')
    expect(page).to have_content('Seguradora')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Período Mínimo')
    expect(page).to have_content('Período Máximo')
    expect(page).to have_content('Status')

    expect(page).to have_content('Smartphones')
    expect(page).to have_link('Seguradora')
    expect(page).to have_content('Premium')
    expect(page).to have_content('12 meses')
    expect(page).to have_content('24 meses')
    expect(page).to have_content('Pendente')
    expect(page).to have_content('Econômico')
    expect(page).to have_content('6 meses')
    expect(page).to have_content('18 meses')
  end
end
