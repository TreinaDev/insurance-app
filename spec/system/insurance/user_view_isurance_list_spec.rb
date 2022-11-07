require 'rails_helper'

describe 'Usuário vê lista de seguradoras' do
  it 'a partir da tela inicial' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
    InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br')

    login_as(user)
    visit root_path
    click_on 'Seguradoras'

    expect(page).to have_content 'Porto Seguro'
    expect(page).to have_content 'Ativo'
  end
end
