require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    seguradora = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br')

    visit root_path
    click_on 'Entrar'
    click_on 'Cadastre-se'
    fill_in 'Nome', with: 'Pessoa'
    fill_in 'E-mail', with: 'pessoa@seguradoraa.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    expect(page).to have_content 'Pessoa'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
  end
end