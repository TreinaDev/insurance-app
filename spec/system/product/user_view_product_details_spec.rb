require 'rails_helper'

describe 'Usuário acessa página de um produto específico' do
  it 'e vê detalhes se for adm' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
    product_category = ProductCategory.create!(name: 'Celular')
    product = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                              product_category:)
    image_path = Rails.root.join('spec/support/images/galaxy-s20-produto.jpg')
    product.image.attach(io: image_path.open, filename: 'galaxy-s20-produto.jpg')

    login_as(user)
    visit root_path
    click_on('Produtos')
    click_on('Samsung Galaxy S20')

    expect(page).to have_content('Samsung Galaxy S20')
    expect(page).to have_content('Ano de Lançamento: 2018')
    expect(page).to have_content('Marca: Samsung')
    expect(page).to have_content('Preço: R$ 2.000,00')
    expect(page).to have_content('Categoria: Celular')
    expect(page).to have_css('img[src*="galaxy-s20-produto.jpg"]')
  end

  it 'a partir da tela de listar produtos e não tem imagem cadastrada' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
    product_category = ProductCategory.create!(name: 'Celular')
    Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                    product_category_id: product_category.id)

    login_as(user)
    visit root_path
    click_on('Produtos')
    click_on('Samsung Galaxy S20')

    expect(page).to have_content('Samsung Galaxy S20')
    expect(page).to have_content('Ano de Lançamento: 2018')
    expect(page).to have_content('Marca: Samsung')
    expect(page).to have_content('Preço: R$ 2.000,00')
    expect(page).to have_content('Categoria: Celular')
    expect(page).to have_css('img[src*="produto"]')
  end

  it 'e vê volta para tela anterior' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
    product_category = ProductCategory.create!(name: 'Celular')
    product = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung',
                              price: 2000.0, product_category_id: product_category.id)
    image_path = Rails.root.join('spec/support/images/galaxy-s20-produto.jpg')
    product.image.attach(io: image_path.open, filename: 'galaxy-s20-produto.jpg')

    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Samsung Galaxy S20'
    click_on 'Voltar'

    expect(current_path).to eq products_path
  end

  it 'e é redirecionado para tela de login se não tiver autenticado' do
    product_category = ProductCategory.create!(name: 'Celular')
    product = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung',
                              price: 2000.0, product_category_id: product_category.id)

    visit product_path product.id

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
    expect(current_path).to eq user_session_path
  end
end
