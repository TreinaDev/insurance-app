require 'rails_helper'

describe 'Administrador cadastra categoria de produto' do
  it 'com sucesso' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '19805576000154')
    admin = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

    login_as(admin)
    visit root_path
    click_on 'Categorias de Produto'
    click_on 'Cadastrar nova Categoria'
    fill_in 'Nome',	with: 'TV'
    click_on 'Salvar'

    expect(page).to have_content 'Categoria de produto cadastrada com sucesso'
    expect(page).to have_content 'Nome da Categoria: TV'
  end

  it 'com erro' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '19805576000154')
    admin = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

    login_as(admin)
    visit root_path
    click_on 'Categorias de Produto'
    click_on 'Cadastrar nova Categoria'
    fill_in 'Nome',	with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Ocorreu um erro'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end
