require 'rails_helper'

describe 'Administrador cadastra categoria de produto' do
  it 'a partir da lista de categorias' do
    admin = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    ProductCategory.create!(name: 'Celular')
    ProductCategory.create!(name: 'Desktop')
    ProductCategory.create!(name: 'Tablet')

    login_as(admin)
    visit root_path
    click_on 'Categorias de Produto'
    click_on 'Cadastrar Categoria'

    expect(page).to have_content 'Cadastrar Categoria de Produto'
    within 'main' do
      expect(page).to have_content 'Categorias de Produto'
    end
    expect(page).to have_content 'Celular'
    expect(page).to have_content 'Desktop'
    expect(page).to have_content 'Tablet'
  end

  it 'com sucesso' do
    admin = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

    login_as(admin)
    visit root_path
    click_on 'Categorias de Produto'
    click_on 'Cadastrar Categoria'
    fill_in 'Nome',	with: 'TV'
    click_on 'Salvar'

    expect(page).to have_content 'Categoria de produto cadastrada com sucesso'
    expect(page).to have_content 'TV'
  end

  it 'com erro' do
    admin = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

    login_as(admin)
    visit root_path
    click_on 'Categorias de Produto'
    click_on 'Cadastrar Categoria'
    fill_in 'Nome',	with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Ocorreu um erro'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end
