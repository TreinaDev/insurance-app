require 'rails_helper'

describe 'Usuário cadastra um produto' do
  it 'a partir da página formulário' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', cnpj: '80958759000110')
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Produto'

    expect(page).to have_field 'Modelo de Produto'
    expect(page).to have_field 'Ano de Lançamento'
    expect(page).to have_field 'Marca'
    expect(page).to have_field 'Preço'
    expect(page).to have_select 'Status'
    expect(page).to have_select 'Categoria'
    expect(page).to have_button 'Criar Produto'
  end

  it 'com sucesso' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', cnpj: '80958759000110')
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    ProductCategory.create!(name: 'Smartphones')
    ProductCategory.create!(name: 'Laptops')

    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Produto'
    fill_in 'Modelo de Produto', with: 'ABCD'
    fill_in 'Ano de Lançamento', with: '2021'
    fill_in 'Marca', with: 'Samsung'
    fill_in 'Preço', with: '1200'
    select 'Ativo', from: 'Status'
    select 'Smartphones', from: 'Categoria'
    click_on 'Criar Produto'

    expect(page).to have_content('Produto criado com sucesso!')
    expect(current_path).to eq(product_path(Product.last.id))
    expect(page).to have_content('ABCD')
    expect(page).to have_content('2021')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('R$ 1.200,00')
    expect(page).to have_content('Smartphones')
  end

  it 'faltando informações' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', cnpj: '80958759000110')
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    ProductCategory.create!(name: 'Smartphones')
    ProductCategory.create!(name: 'Laptops')

    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Produto'
    fill_in 'Modelo de Produto', with: ''
    fill_in 'Ano de Lançamento', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Preço', with: ''
    click_on 'Criar Produto'

    expect(page).to have_content('Produto não foi criado')
    expect(page).to have_content('Modelo de Produto não pode ficar em branco')
    expect(page).to have_content('Ano de Lançamento não pode ficar em branco')
    expect(page).to have_content('Marca não pode ficar em branco')
    expect(page).to have_content('Preço não pode ficar em branco')
  end

  it 'e não é administrador' do
    InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', cnpj: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    ProductCategory.create!(name: 'Smartphones')
    ProductCategory.create!(name: 'Laptops')

    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Adicionar Produto'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Apenas usuários administradores tem acesso a essa função')
  end
end
