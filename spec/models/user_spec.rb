require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'nome é obrigatório' do
        user = User.new(name: '')

        user.valid?

        expect(user.errors.include?(:name)).to be true
      end

      it 'e-mail é obrigatório' do
        user = User.new(email: '')

        user.valid?

        expect(user.errors.include?(:email)).to be true
      end

      it 'senha é obrigatória' do
        user = User.new(password: '')

        user.valid?

        expect(user.errors.include?(:password)).to be true
      end
    end

    context 'unique' do
      it 'e-mail é único' do
        InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br', cnpj: '73328094000104')
        User.create!(name: 'Pessoa', email: 'pessoa@seguradoraa.com.br', password: 'password')
        user = User.new(email: 'pessoa@seguradoraa.com.br')

        user.valid?

        expect(user.errors.include?(:email)).to be true
      end
    end
  end

  describe '#employee?' do
    it 'o usuário é um funcionário por padrão' do
      InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br', cnpj: '73328094000104')
      user = User.create!(name: 'Pessoa', email: 'pessoa@seguradoraa.com.br', password: 'password')

      expect(user.employee?).to be true
    end
  end

  describe 'atribui uma empresa' do
    it 'ao criar um usuário' do
      seguradora = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                            cnpj: '73328094000104')
      InsuranceCompany.create!(name: 'Seguradora B', email_domain: 'seguradorab.com.br', cnpj: '00028094000104')
      user = User.create!(name: 'Pessoa', email: 'pessoa@seguradoraa.com.br', password: 'password')

      expect(user.insurance_company_id).to eq seguradora.id
    end
  end
end
