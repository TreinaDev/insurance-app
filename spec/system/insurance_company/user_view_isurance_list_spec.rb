require 'rails_helper'

describe 'Usuário vê lista de seguradoras' do
  it 'a partir da tela inicial' do
    InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                             company_status: 1, registration_number: '84157841000105')
    InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br',
                             registration_number: '99157841000105')

    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Seguradoras'

    expect(page).to have_content 'Nome da Seguradora'
    expect(page).to have_content 'CNPJ'
    expect(page).to have_content 'Status da Seguradora'
    expect(page).to have_content 'Porto Seguro'
    expect(page).to have_content 'Ativo'
    expect(page).to have_content '99157841000105'
    expect(page).to have_content 'Allianz Seguros'
    expect(page).to have_content 'Inativo'
    expect(page).to have_content '84157841000105'
  end

  it 'e não tem nenhuma seguradora' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Seguradoras'

    expect(page).to have_content 'Não existem seguradoras cadastradas'
  end

  it 'funcionário não possui acesso a essa página' do
    InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                             registration_number: '44639834000117')
    user = User.create!(name: 'Aline', email: 'Aline@allianzaeguros.com.br', password: 'password', role: :employee)

    login_as(user)
    visit root_path

    expect(page).not_to have_link insurance_companies_path
  end
end
