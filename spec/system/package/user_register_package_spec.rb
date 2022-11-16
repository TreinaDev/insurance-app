require 'rails_helper'

describe 'Usuário cadastra um pacote de seguro' do
  it 'é funcionário e vê o formulario' do
    InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                            '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Adicionar Pacote'

    expect(page).to have_content 'Cadastrar Novo Pacote'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Período Mínimo'
    expect(page).to have_field 'Período Máximo'
    expect(page).to have_select 'Categoria'
    expect(page).to have_button 'Criar Pacote'
  end

  it 'com sucesso' do
    InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br', registration_number:
                            '80958759000110')
    user = User.create!(email: 'email@seguradoraa.com.br', password: 'password', name: 'Maria', role: :employee)
    ProductCategory.create!(name: 'Laptops')
    ProductCategory.create!(name: 'Smartphones')

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Adicionar Pacote'
    fill_in 'Nome', with: 'Premium'
    fill_in 'Período Mínimo', with: '12'
    fill_in 'Período Máximo', with: '24'
    select 'Smartphones', from: 'Categoria'
    click_on 'Criar Pacote'

    expect(page).to have_content 'Pacote cadastrado com sucesso!'
    expect(page).to have_content 'Smartphones'
    expect(page).to have_content 'Seguradora A'
    expect(page).to have_content 'Premium'
    expect(page).to have_content '12 meses'
    expect(page).to have_content '24 meses'
    expect(page).to have_content 'Pendente'
  end

  it 'faltando informação' do
    InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br', registration_number:
                            '80958759000110')
    user = User.create!(email: 'email@seguradoraa.com.br', password: 'password', name: 'Maria', role: :employee)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Adicionar Pacote'
    fill_in 'Nome', with: ''
    fill_in 'Período Mínimo', with: ''
    fill_in 'Período Máximo', with: ''
    click_on 'Criar Pacote'

    expect(page).to have_content 'Não foi possível cadastrar o pacote'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Período Mínimo não pode ficar em branco'
    expect(page).to have_content 'Período Máximo não pode ficar em branco'
  end

  it 'e é administrador' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password',
                        role: :admin)

    login_as(user)
    visit root_path
    click_on 'Pacotes'

    expect(page).not_to have_content('Adicionar Pacote')
  end
end
