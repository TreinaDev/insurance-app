require 'rails_helper'

describe 'Usuário registra um produto' do
  it 'e não é administrador' do
    InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br',
                             registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    category = ProductCategory.create!(name: 'Smartphones')

    login_as(user)
    post(products_path, params: { product: { product_model: 'ABCD', lanch_year: '2016', brand: 'Samsung',
                                             price: 1200.00, status: :active, product_category: category } })

    expect(response).to redirect_to(root_path)
    expect(Product.all.length).to eq(0)
  end
end
