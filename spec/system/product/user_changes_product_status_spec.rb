require 'rails_helper'

describe 'Usuário altera status do produto' do
  context 'como administrador' do
    it 'para inativo' do
      InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
      admin = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
      product_category = ProductCategory.create!(name: 'Celular')
      Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                      product_category:, status: :active)
      
      login_as admin
      visit root_path
      click_on 'Produtos'
      click_on 'Samsung Galaxy S20'
      click_on 'Desativar'

      expect(page).to have_content 'Produto desativado com sucesso'
      expect(page).to have_content 'Samsung Galaxy S20'
      expect(page).to have_content 'Status: Inativo'
      expect(page).to have_button 'Ativar'
      expect(page).not_to have_button 'Desativar'
    end

    it 'para ativo' do
      InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
      admin = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
      product_category = ProductCategory.create!(name: 'Celular')
      Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                      product_category:, status: :inactive)
      
      login_as admin
      visit root_path
      click_on 'Produtos'
      click_on 'Samsung Galaxy S20'
      click_on 'Ativar'

      expect(page).to have_content 'Produto ativado com sucesso'
      expect(page).to have_content 'Samsung Galaxy S20'
      expect(page).to have_content 'Status: Ativo'
      expect(page).not_to have_button 'Ativar'
      expect(page).to have_button 'Desativar'
    end
  end

  context 'como funcionário' do
    it 'para inativo' do
      InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br')
      user = User.create!(name: 'Aline', email: 'Aline@seguradoraa.com.br', password: 'password', role: :employee)
      product_category = ProductCategory.create!(name: 'Celular')
      Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                      product_category:, status: :active)
      
      login_as user
      visit root_path
      click_on 'Produtos'
      click_on 'Samsung Galaxy S20'

      expect(page).not_to have_button 'Desativar'
    end

    it 'para ativo' do
      InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br')
      user = User.create!(name: 'Aline', email: 'Aline@seguradoraa.com.br', password: 'password', role: :employee)
      product_category = ProductCategory.create!(name: 'Celular')
      Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                      product_category:, status: :inactive)
      
      login_as user
      visit root_path
      click_on 'Produtos'
      click_on 'Samsung Galaxy S20'

      expect(page).not_to have_button 'Ativar'
    end
  end
end