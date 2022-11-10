require 'rails_helper'

describe 'Usuário atualiza um produto' do
  it 'e não é administrador' do
    InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br',
                             registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    category = ProductCategory.create!(name: 'Smartphones')
    product = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                              product_category: category)

    login_as(user)
    patch(product_path(product.id), params: { product: { product_model: 'Samsung', lanch_year: '2016', brand: 'Samsung',
                                                         price: 2000.00, status: :active,
                                                         product_category: category } })

    expect(response).to redirect_to(root_path)
  end
end
