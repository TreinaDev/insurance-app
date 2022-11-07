require 'rails_helper'

describe 'Usuário vê lista de seguradoras' do
  it 'a partir da tela inicial' do
    
    InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br')
    user = User.create!(name: 'Aline', email: 'Aline@portoseguro.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Seguradoras'

    expect(page).to have_content 'Porto Seguro'
    expect(page).to have_content 'Ativo'
  end
end
