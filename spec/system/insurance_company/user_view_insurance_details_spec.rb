require 'rails_helper'

describe 'Usuário administrador vê detalhes da Seguradora' do
    it 'a partir da tela de listar seguradoras' do        
        InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '44639834000117')
        user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)         
        
        InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br', registration_number: '99157841000105', company_status: :inactive)
        allow(SecureRandom).to receive(:alphanumeric).with(20).and_return('ABCDEFGHIJ0123456789') 

        login_as(user)
        visit root_path
        click_on 'Seguradoras'
        click_on 'Porto Seguro'

        expect(page).to have_content('Porto Seguro')
        expect(page).to have_content('Inativo')
        expect(page).to have_content('CNPJ:')
        expect(page).to have_content('99157841000105')
        expect(page).to have_content('Domínio de E-mail:')
        expect(page).to have_content('portoseguro.com.br')
        expect(page).to have_content('Token de Integração:')
        expect(page).to have_content('Ativo - ABCDEFGHIJ0123456789')

    end
end
