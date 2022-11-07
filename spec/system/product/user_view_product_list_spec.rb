require 'rails_helper'

describe 'Administrador vê lista de produtos' do
  it 'com sucesso' do
<<<<<<< HEAD
    product_category = ProductCategory.create!(name: 'TV')
    Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG',
                    price: 5000, product_category: product_category)
    Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'SAMSUNG',
                    price: 8000, product_category: product_category)

=======
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
    product_category = ProductCategory.create!(name: 'TV')
    Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000,
                    product_category:)
    Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'SAMSUNG', price: 8000,
                    product_category:)

    login_as(user)
>>>>>>> 015d2e7a4ba200fde2c10e3586e281d25e25c687
    visit products_path

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'LG'
    expect(page).to have_content 'TV 50'
    expect(page).to have_content 'SAMSUNG'
  end

  it 'e não tem nenhum produto' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit products_path

    expect(page).to have_content 'Não existem produtos cadastrados'
  end
end
