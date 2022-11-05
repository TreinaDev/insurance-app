require 'rails_helper'

describe 'Usuário registra um produto' do
  it 'e não é administrador' do
    user = User.create!(email: 'email@admin.com', password: 'password', name: 'Maria', role: :employee)
    product_category = ProductCategory.create!(name: 'Smartphones')

    login_as(user)
    post(products_path, params: { product: { product_model: 'ABCD', lanch_year: '2016', brand: 'Samsung', 
                                            price: 1200.00, status: :active, product_category: product_category}})
    
    expect(response).to redirect_to(root_path)
    expect(Product.all.length).to eq(0)
  end 
end