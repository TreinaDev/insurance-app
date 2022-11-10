require 'rails_helper'

describe 'Usuário altera o status de um produto' do
  context 'para inativa' do
    it 'e não está autenticado' do
      product_category = ProductCategory.create!(name: 'Celular')
      product = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung',
                                price: 2000.0, product_category:, status: :active)

      post(deactivate_product_path(product.id))

      expect(response).to redirect_to(new_user_session_url)
    end

    it 'como funcionário' do
      InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                               registration_number: '05681642000117')
      user = User.create!(name: 'Aline', email: 'Aline@seguradoraa.com.br', password: 'password', role: :employee)
      product_category = ProductCategory.create!(name: 'Celular')
      product = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung',
                                price: 2000.0, product_category:, status: :active)

      login_as user
      post(deactivate_product_path(product.id))

      expect(response.status).not_to be 200
    end
  end

  context 'para ativa' do
    it 'e não está autenticado' do
      product_category = ProductCategory.create!(name: 'Celular')
      product = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung',
                                price: 2000.0, product_category:, status: :inactive)

      post(activate_product_path(product.id))

      expect(response).to redirect_to(new_user_session_url)
    end

    it 'como funcionário' do
      user = User.create!(name: 'Aline', email: 'Aline@seguradoraa.com.br', password: 'password', role: :employee)
      product_category = ProductCategory.create!(name: 'Celular')
      product = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung',
                                price: 2000.0, product_category:, status: :inactive)

      login_as user
      post(activate_product_path(product.id))

      expect(response.status).not_to be 200
    end
  end
end
