require 'rails_helper'

describe 'Usuário vê lista de seguradoras' do
  it 'a partir da tela inicial' do
    InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br', company_status: 1)
    InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br')
    user = User.create!(name: 'Aline', email: 'Aline@portoseguro.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Seguradoras'

    expect(page).to have_content 'Porto Seguro'
    expect(page).to have_content 'Ativo'
    expect(page).to have_content 'Allianz Seguros'
    expect(page).to have_content 'Inativo'
  end

  it 'e não possui acesso a essa página' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Seguradoras'

    expect(page).to have_content 'Não existem seguradoras cadastradas'
  end

  it 'e não tem nenhuma seguradora' do
    InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br')
    user = User.create!(name: 'Aline', email: 'Aline@allianzaeguros.com.br', password: 'password', role: :employee)

    login_as(user)
    visit root_path
    click_on 'Seguradoras'

    expect(page).to have_content 'Apenas usuários administradores tem acesso a essa função'
  end
end
