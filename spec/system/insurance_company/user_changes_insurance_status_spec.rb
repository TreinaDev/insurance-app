require 'rails_helper'

describe 'Usuário altera status da seguradora' do
  context 'como administrador' do
    it 'para inativo' do
      admin = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
      insurance_a = InsuranceCompany.create!(name: 'Liga de Seguros', email_domain: 'ligadeseguros.com.br',
                                             registration_number: '01333288000189')
      logo_path = Rails.root.join('spec/support/logos/liga_seguros.PNG')
      insurance_a.logo.attach(io: logo_path.open, filename: 'liga_seguros.PNG')

      login_as admin
      visit root_path
      click_on 'Seguradoras'
      click_on 'Liga de Seguros'
      click_on 'Desativar'

      expect(page).to have_content 'Seguradora desativado com sucesso'
      expect(page).to have_content "Liga de Seguros -\nInativo"
      expect(page).to have_button 'Ativar'
      expect(page).not_to have_button 'Desativar'
    end

    it 'para ativo' do
      admin = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
      insurance_a = InsuranceCompany.create!(name: 'Liga de Seguros', email_domain: 'ligadeseguros.com.br',
                                             registration_number: '01333288000189', company_status: :inactive)
      logo_path = Rails.root.join('spec/support/logos/liga_seguros.PNG')
      insurance_a.logo.attach(io: logo_path.open, filename: 'liga_seguros.PNG')

      login_as admin
      visit root_path
      click_on 'Seguradoras'
      click_on 'Liga de Seguros'
      click_on 'Ativar'

      expect(page).to have_content 'Seguradora ativada com sucesso'
      expect(page).to have_content "Liga de Seguros -\nAtivo"
      expect(page).to have_button 'Desativar'
      expect(page).not_to have_button 'Ativar'
    end
  end
end
