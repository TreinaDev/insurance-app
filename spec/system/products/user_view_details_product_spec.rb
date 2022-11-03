require 'rails_helper'
 
 
describe 'Usuário visualiza página de um produto específico' do
  it 'e vê detalhes' do
 
    category = ProductCategory.create!(name: "Celular")

    Product.create!(product_model: "Samsung Galaxy S20", launch_year: "2018", brand: "Samsung", price: '2000.0', product_category: category)

    visit product_path(id:1)

    expect(page).to have_content("Samsung Galaxy S20")
    expect(page).to have_content("Ano de lançamento: 2018")
    expect(page).to have_content("Marca: Samsung")    
    expect(page).to have_content("Preço: 2000.0")
    expect(page).to have_content("Categoria: Celular")


  end
end
