require 'rails_helper'

describe 'Usuário faz login' do

  context 'como administrador' do
    it 'com sucesso' do
      # Arrange
      User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
  
      # Act
      visit root_path
      within 'nav' do
        click_on 'Entrar'
      end
      within 'form' do
        fill_in 'E-mail', with: 'pessoa@empresa.com.br'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'
      end
  
      # Assert
      within 'nav' do
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_link 'Seguradoras'
        expect(page).to have_link 'Coberturas'
        expect(page).to have_link 'Serviços'
        expect(page).to have_link 'Produtos'
        expect(page).to have_link 'Categorias de Produtos'
        expect(page).to have_button 'Sair'
        expect(page).to have_content 'Pessoa'
      end
        expect(page).to have_content 'Login efetuado com sucesso.'
    end

    it 'e faz logout' do
      # Arrange
      admin = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
  
      # Act
      login_as admin
      visit root_path
      click_on 'Pessoa'
      click_on 'Sair'
  
      # Assert
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_link 'Sair'
      expect(page).not_to have_link 'Coberturas'
      expect(page).not_to have_link 'Serviços'
      expect(page).not_to have_link 'Produtos'
      expect(page).not_to have_link 'Categorias de Produtos'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_button 'Pessoa'
      expect(page).to have_content 'Logout efetuado com sucesso.'
    end
  end
end