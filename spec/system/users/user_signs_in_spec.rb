require 'rails_helper'

describe 'Usuário faz login' do
  context 'como administrador' do
    it 'com sucesso' do
      User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

      visit root_path
      within 'nav' do
        click_on 'Entrar'
      end
      within 'form' do
        fill_in 'E-mail', with: 'pessoa@empresa.com.br'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'
      end

      within 'nav' do
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_link 'Produtos'
        expect(page).to have_button 'Sair'
        expect(page).to have_content 'Pessoa'
      end
      expect(page).to have_content 'Login efetuado com sucesso.'
    end

    it 'e faz logout' do
      admin = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

      login_as admin
      visit root_path
      click_on 'Pessoa'
      click_on 'Sair'

      expect(page).to have_link 'Entrar'
      expect(page).not_to have_link 'Sair'
      expect(page).not_to have_link 'Produtos'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_button 'Pessoa'
      expect(page).to have_content 'Logout efetuado com sucesso.'
    end
  end
  context 'como funcionário' do
    it 'com sucesso' do
      InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                               registration_number: '73328094000104')
      User.create!(name: 'Edna', email: 'edna@seguradoraa.com.br', password: 'password', role: :employee)

      visit root_path
      within 'nav' do
        click_on 'Entrar'
      end
      within 'form' do
        fill_in 'E-mail', with: 'edna@seguradoraa.com.br'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'
      end

      within 'nav' do
        expect(page).not_to have_link 'Entrar'
        expect(page).not_to have_link insurance_companies_path
        expect(page).to have_link 'Produtos'
        expect(page).to have_button 'Sair'
        expect(page).to have_content 'Edna'
      end
      expect(page).to have_content 'Login efetuado com sucesso.'
    end
  end
end
