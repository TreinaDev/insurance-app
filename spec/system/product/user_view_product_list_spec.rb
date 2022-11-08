require 'rails_helper'

describe 'Administrador vê lista de produtos' do
<<<<<<< HEAD
  it 'com sucesso' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '80958759000110')
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
=======
  it 'com sucesso e é admin' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
>>>>>>> main
    product_category = ProductCategory.create!(name: 'TV')
    Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG',
                    price: 5000, product_category_id: product_category.id)
    Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'SAMSUNG',
                    price: 8000, product_category_id: product_category.id)

    login_as(user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Lista de Produtos'
    expect(page).to have_content 'Modelo do Produto: TV 32 - LG'
    expect(page).to have_content 'Modelo do Produto: TV 50 - SAMSUNG'
  end

<<<<<<< HEAD
  it 'e não tem nenhum produto' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '80958759000110')
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
=======
  it 'com sucesso e é funcionário de seguradora' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
    user = User.create!(name: 'Edna', email: 'edna@empresa.com.br', password: 'password', role: :employee)
    product_category = ProductCategory.create!(name: 'TV')
    Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG',
                    price: 5000, product_category_id: product_category.id)
    Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'SAMSUNG',
                    price: 8000, product_category_id: product_category.id)

    login_as(user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Lista de Produtos'
    expect(page).to have_content 'Modelo do Produto: TV 32 - LG'
    expect(page).to have_content 'Modelo do Produto: TV 50 - SAMSUNG'
  end

  it 'e não tem nenhum produto cadastrado' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
>>>>>>> main

    login_as(user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Não existem produtos cadastrados'
  end
end
