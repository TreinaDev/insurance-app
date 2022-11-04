require 'rails_helper'

describe 'Usuário adm visualiza página de um produto específico' do
  it 'e vê detalhes' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)

    product_category = ProductCategory.create!(name: 'Celular')

    Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                    product_category:)

    login_as(user)
    visit root_path
    click_on('Produtos')
    click_on('Samsung Galaxy S20')

    expect(page).to have_content('Samsung Galaxy S20')
    expect(page).to have_content('Ano de lançamento: 2018')
    expect(page).to have_content('Marca: Samsung')
    expect(page).to have_content('Preço: R$ 2.000,00')
    expect(page).to have_content('Categoria: Celular')
  end
end
