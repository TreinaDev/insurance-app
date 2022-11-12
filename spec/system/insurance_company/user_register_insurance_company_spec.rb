require 'rails_helper'

describe 'Usuário cadastra uma seguradora' do
  it 'a partir da página formulário' do
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Seguradoras'
    click_on 'Adicionar Seguradora'

    expect(page).to have_field 'Nome da Seguradora'
    expect(page).to have_field 'Domínio de E-mail'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Logo da Seguradora'
  end

  it 'com sucesso' do
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Seguradoras'
    click_on 'Adicionar Seguradora'
    fill_in 'Nome da Seguradora', with: 'Porto Seguro'
    fill_in 'Domínio de E-mail', with: '@portoseguro.com.br'
    fill_in 'CNPJ', with: '75570985000190'
    attach_file 'Logo da Seguradora', Rails.root.join('spec/support/logos/porto_seguro.PNG')
    click_on 'Criar Seguradora'

    expect(page).to have_content('Seguradora criada com sucesso!')
    expect(current_path).to eq(insurance_company_path(InsuranceCompany.last.id))
    expect(page).to have_content('Porto Seguro')
    expect(page).to have_content('75570985000190')
    expect(page).to have_content('Ativo')
    expect(page).to have_css('img[src*="porto_seguro.PNG"]')
    insurance = InsuranceCompany.last
    expect(insurance.active?).to be true
  end

  it 'faltando informações' do
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Seguradoras'
    click_on 'Adicionar Seguradora'
    fill_in 'Nome da Seguradora', with: ''
    fill_in 'Domínio de E-mail', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Criar Seguradora'

    expect(page).to have_content('Seguradora não foi criada')
    expect(page).to have_content('Nome da Seguradora não pode ficar em branco')
    expect(page).to have_content('Domínio de E-mail não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
  end

  it 'e não é administrador' do
    InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br',
                             registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)

    login_as(user)
    visit root_path
    click_on 'Seguradoras'

    expect(page).not_to have_link('Adicionar Seguradora')
  end
end
