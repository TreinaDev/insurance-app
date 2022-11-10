require 'rails_helper'

describe 'Usuário vê lista de Categorias de Produto' do
  it 'com sucesso' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '19805576000154')
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password')
    ProductCategory.create!(name: 'Celular')
    ProductCategory.create!(name: 'Desktop')
    ProductCategory.create!(name: 'Tablet')

    login_as(user)
    visit root_path
    click_on 'Categorias de Produto'

    expect(page).to have_content 'Lista de Categorias de Produto'
    expect(page).to have_content 'Nome da Categoria: Celular'
    expect(page).to have_content 'Nome da Categoria: Desktop'
    expect(page).to have_content 'Nome da Categoria: Tablet'
  end

  it 'e não vê botão para cadastrar nova Categoria' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '19805576000154')
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password')
    ProductCategory.create!(name: 'Celular')
    ProductCategory.create!(name: 'Desktop')
    ProductCategory.create!(name: 'Tablet')

    login_as(user)
    visit root_path
    click_on 'Categorias de Produto'

    expect(page).to have_content 'Lista de Categorias de Produto'
    expect(page).to have_content 'Nome da Categoria: Celular'
    expect(page).to have_content 'Nome da Categoria: Desktop'
    expect(page).to have_content 'Nome da Categoria: Tablet'
    expect(page).not_to have_link 'Cadastrar nova Categoria'
  end

  it 'e não existem Categorias cadastradas' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '19805576000154')
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password')

    login_as(user)
    visit root_path
    click_on 'Categorias de Produto'

    expect(page).to have_content 'Lista de Categorias de Produto'
    expect(page).not_to have_content 'Nome da Categoria'
    expect(page).not_to have_content 'Nome da Categoria: Desktop'
    expect(page).to have_content 'Não existem Categorias de Produto cadastradas'
  end

  it 'e volta para a página inicial' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '19805576000154')
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password')

    login_as(user)
    visit root_path
    click_on 'Categorias de Produto'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end
