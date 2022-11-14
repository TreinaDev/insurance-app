require 'rails_helper'

describe 'Usuário vê lista de produtos' do
  it 'com sucesso e é admin' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    product_category_a = ProductCategory.create!(name: 'Televisão')
    product_category_b = ProductCategory.create!(name: 'Celular')
    Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000.0,
                    product_category: product_category_a, status: :active)
    Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                    product_category: product_category_b, status: :inactive)
    Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'Samsung', price: 8000,
                    product_category: product_category_a, status: :inactive)

    login_as(user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Categoria'
    expect(page).to have_content 'Marca'
    expect(page).to have_content 'Modelo'
    expect(page).to have_content 'Ano de Lançamento'
    expect(page).to have_content 'Status'
    within("#product_category_#{product_category_a.id}") do
      expect(page).to have_content 'Televisão'
      expect(page).to have_content 'TV 32'
      expect(page).to have_content '2022'
      expect(page).to have_content 'LG'
      expect(page).to have_content 'Ativo'
      expect(page).to have_content 'TV 50'
      expect(page).to have_content '2021'
      expect(page).to have_content 'Samsung'
      expect(page).to have_content 'Inativo'
    end
    within("#product_category_#{product_category_b.id}") do
      expect(page).to have_content 'Celular'
      expect(page).to have_content '2018'
      expect(page).to have_content 'Samsung'
      expect(page).to have_content 'Inativo'
    end
  end

  it 'com sucesso e é funcionário de seguradora' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '80958759000110')
    user = User.create!(name: 'Edna', email: 'edna@empresa.com.br', password: 'password', role: :employee)
    product_category_a = ProductCategory.create!(name: 'Televisão')
    product_category_b = ProductCategory.create!(name: 'Celular')
    Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000.0,
                    product_category: product_category_a, status: :active)
    Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                    product_category: product_category_b, status: :inactive)
    Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'Samsung', price: 8000,
                    product_category: product_category_a, status: :inactive)

    login_as(user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Categoria'
    expect(page).to have_content 'Marca'
    expect(page).to have_content 'Modelo'
    expect(page).to have_content 'Ano de Lançamento'
    expect(page).to have_content 'Status'
    within("#product_category_#{product_category_a.id}") do
      expect(page).to have_content 'Televisão'
      expect(page).to have_content 'TV 32'
      expect(page).to have_content '2022'
      expect(page).to have_content 'LG'
      expect(page).to have_content 'Ativo'
      expect(page).to have_content 'TV 50'
      expect(page).to have_content '2021'
      expect(page).to have_content 'Samsung'
      expect(page).to have_content 'Inativo'
    end
    within("#product_category_#{product_category_b.id}") do
      expect(page).to have_content 'Celular'
      expect(page).to have_content '2018'
      expect(page).to have_content 'Samsung'
      expect(page).to have_content 'Inativo'
    end
  end

  it 'e não tem nenhum produto cadastrado' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Não existem produtos cadastrados'
  end
end
