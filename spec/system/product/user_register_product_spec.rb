require 'rails_helper'

describe 'Usuário cadastra um produto' do
  it 'a partir da página formulário' do
    user = User.create!(email: 'email@admin.com', password: 'password', name: 'Maria', role: :admin)

    login_as(user)
    visit new_product_url

    expect(page).to have_field 'Modelo de Produto'
    expect(page).to have_field 'Ano de Lançamento'
    expect(page).to have_field 'Marca'
    expect(page).to have_field 'Preço'
    expect(page).to have_select 'Status'
    expect(page).to have_select 'Categoria'
    expect(page).to have_button 'Enviar'
  end

  it 'com sucesso' do
    user = User.create!(email: 'email@admin.com', password: 'password', name: 'Maria', role: :admin)
    ProductCategory.create!(name: "Smartphones")
    ProductCategory.create!(name: "Laptops")

    login_as(user)
    visit new_product_url
    fill_in 'Modelo de Produto', with: 'ABCD'
    fill_in 'Ano de Lançamento', with: '2021'
    fill_in 'Marca', with: 'Samsung'
    fill_in 'Preço', with: '1200'
    select 'Ativo', from: 'Status'
    select 'Smartphones', from: 'Categoria'
    click_on 'Enviar'

    expect(page).to have_content('Produto criado com sucesso!')
    expect(current_path).to eq(new_product_path)
  end

  it 'com sucesso' do
    user = User.create!(email: 'email@admin.com', password: 'password', name: 'Maria', role: :admin)
    ProductCategory.create!(name: "Smartphones")
    ProductCategory.create!(name: "Laptops")

    login_as(user)
    visit new_product_url
    fill_in 'Modelo de Produto', with: ''
    fill_in 'Ano de Lançamento', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Preço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Produto não foi criado')
    expect(page).to have_content('Modelo de Produto não pode ficar em branco')
    expect(page).to have_content('Ano de Lançamento não pode ficar em branco')
    expect(page).to have_content('Marca não pode ficar em branco')
    expect(page).to have_content('Preço não pode ficar em branco')
  end
end 