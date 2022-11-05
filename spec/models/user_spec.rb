require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'atribui uma empresa' do
    it 'ao criar um usuário' do
      seguradora = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br')
      usuario = User.create!(name: 'Pessoa', email: 'pessoa@seguradoraa.com.br', password: 'password')

      expect(usuario.insurance_company_id).to eq seguradora.id
    end
  end
end
