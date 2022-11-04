require 'rails_helper'

describe 'Administrador vê lista de produtos' do
  it 'com sucesso' do    
    product_category = ProductCategory.create!(name: 'TV')
    product = Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000, product_category: product_category)
    other_product = Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'SAMSUNG', price: 8000, product_category: product_category)
    
    visit products_path
    
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'LG'
    expect(page).to have_content 'TV 50'
    expect(page).to have_content 'SAMSUNG'
  end

  it 'e não tem nenhum produto' do
    visit products_path

    expect(page).to have_content 'Não existem produtos cadastrados'
  end
end

   