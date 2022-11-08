require 'rails_helper'

describe 'Administrador vê lista de produtos' do
  it 'com sucesso' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
    product_category = ProductCategory.create!(name: 'TV')
    Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000,
                    product_category:, status: :active)
    Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'SAMSUNG', price: 8000,
                    product_category:, status: :inactive)

    login_as(user)
    visit products_path

    expect(page).to have_content 'Categoria'
    expect(page).to have_content 'Marca'
    expect(page).to have_content 'Modelo'
    expect(page).to have_content 'Ano de Lançamento'
    expect(page).to have_content '2022'
    expect(page).to have_content '2021'
    expect(page).to have_content 'Status'
    expect(page).to have_content 'Ativo'
    expect(page).to have_content 'Inativo'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'LG'
    expect(page).to have_content 'TV 50'
    expect(page).to have_content 'SAMSUNG'
  end

  it 'e não tem nenhum produto' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit products_path

    expect(page).to have_content 'Não existem produtos cadastrados'
  end
end
