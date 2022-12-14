require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                             registration_number: '73328094000104')

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

  it 'e não preenche todos os campos' do
    InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                             registration_number: '73328094000104')

    visit root_path
    click_on 'Entrar'
    click_on 'Cadastre-se'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    click_on 'Criar conta'

    expect(page).to have_content 'Não foi possível salvar usuário: 4 erros.'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'não encontrada'
  end

  it 'e não está associado a uma seguradora' do
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastre-se'
    fill_in 'Nome', with: 'Pessoa'
    fill_in 'E-mail', with: 'pessoa@pessoa.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    expect(page).to have_content 'Não foi possível salvar usuário: 1 erro'
    expect(page).to have_content 'Seguradora não encontrada'
  end
end
