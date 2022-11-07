require 'rails_helper'

describe 'Usuário acessa página de um produto específico' do
  it 'e vê detalhes se for adm' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)

    product_category = ProductCategory.create!(name: 'Celular')

    Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                    product_category:)

    login_as(user)
    visit root_path
    click_on('Produtos')
    click_on('Samsung Galaxy S20')

    expect(page).to have_content('Samsung Galaxy S20')
    expect(page).to have_content('Ano de Lançamento: 2018')
    expect(page).to have_content('Marca: Samsung')
    expect(page).to have_content('Preço: R$ 2.000,00')
    expect(page).to have_content('Categoria: Celular')
  end

  it 'e é redirecionado para tela de login se não tiver autenticado' do
    product_category = ProductCategory.create!(name: 'Celular')
    product = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung',
                              price: 2000.0, product_category:)

    visit product_path product.id

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
    expect(current_path).to eq user_session_path
  end
end
