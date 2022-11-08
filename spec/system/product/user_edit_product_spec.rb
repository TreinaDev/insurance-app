require 'rails_helper'

describe 'Usúario edita um produto' do
  it 'e vê as informações do produto' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    product_category = ProductCategory.create!(name: 'Celular')
    Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                    product_category: product_category)
    
    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Samsung Galaxy S20'
    click_on 'Editar'
    
    expect(page).to have_field('Modelo do Produto', with: 'Samsung Galaxy S20')
    expect(page).to have_field('Ano de Lançamento', with: '2018')
    expect(page).to have_field('Marca', with: 'Samsung')
    expect(page).to have_field('Preço', with: '2000.0')
    expect(page).to have_select('Categoria', selected: 'Celular')
  end

  it 'com sucesso' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    product_category = ProductCategory.create!(name: 'Celular')
    Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                    product_category: product_category)
    
    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Samsung Galaxy S20'
    click_on 'Editar'
    fill_in 'Ano de Lançamento', with: '2019'
    fill_in 'Preço', with: 1900.00
    click_on 'Atualizar Produto'

    expect(page).to have_content('Produto atualizado com sucesso!')
    expect(page).to have_content('Preço: R$ 1.900,00')
    expect(page).to have_content('Ano de Lançamento: 2019')
    expect(page).to have_content('Samsung Galaxy S20')
    expect(page).to have_content('Categoria: Celular')
  end

  it 'com informações faltando' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    product_category = ProductCategory.create!(name: 'Celular')
    Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                    product_category: product_category)
    
    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Samsung Galaxy S20'
    click_on 'Editar'
    fill_in 'Ano de Lançamento', with: ''
    fill_in 'Preço', with: ''
    click_on 'Atualizar Produto'

    expect(page).to have_content('Não foi possivel atualizar produto.')
    expect(page).to have_content('Ano de Lançamento não pode ficar em branco')
    expect(page).to have_content('Preço não pode ficar em branco')
    expect(page).to have_content('Samsung Galaxy S20')
    expect(page).to have_select('Categoria', selected: 'Celular')
  end

  it 'e não é administrador' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :employee)
    product_category = ProductCategory.create!(name: 'Celular')
    Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                    product_category: product_category)
    
    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Samsung Galaxy S20'

    expect(page).not_to have_link('Editar')
  end
end