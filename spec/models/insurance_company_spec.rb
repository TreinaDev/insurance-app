require 'rails_helper'

RSpec.describe InsuranceCompany, type: :model do
  describe '#valid?' do
    it 'falso quando campo de numero de registro fica em branco' do
      insurance = InsuranceCompany.new(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                       registration_number: '')

      expect(insurance.valid?).to eq false
    end

    it 'falso quando campo nome fica em branco' do
      insurance = InsuranceCompany.new(name: '', email_domain: 'seguradoraa.com.br',
                                       registration_number: '02585232145203')

      expect(insurance.valid?).to eq false
    end

    it 'falso quando campo domínio do e-mail fica em branco' do
      insurance = InsuranceCompany.new(name: 'Seguradora A', email_domain: '',
                                       registration_number: '02585232145203')

      expect(insurance.valid?).to eq false
    end

    it 'falso quando campo status da compania fica em branco' do
      insurance = InsuranceCompany.new(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                       registration_number: '02585232145203', company_status: '')

      expect(insurance.valid?).to eq false
    end

    it 'falso quando campo token de status fica em branco' do
      insurance = InsuranceCompany.new(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                       registration_number: '02585232145203', token_status: '')

      expect(insurance.valid?).to eq false
    end

    it 'falso quando campo número de registro é diferente de 14 caracteres' do
      insurance = InsuranceCompany.new(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                       registration_number: '000111')

      expect(insurance.valid?).to eq false
    end

    it 'falso quando campo número de registro já está cadastrado' do
      InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                               registration_number: '02585232145203')
      insurance = InsuranceCompany.new(name: 'Seguradora B', email_domain: 'seguradorab.com.br',
                                       registration_number: '02585232145203')

      expect(insurance.valid?).to eq false
    end
  end

  describe 'gera um código aleatório para o token' do
    it 'ao criar uma seguradora' do
      insurance = InsuranceCompany.create!(name: 'Seguradora B', email_domain: 'seguradorab.com.br',
                                           registration_number: '02585232145203')

      expect(insurance.token).not_to be_empty
      expect(insurance.token.length).to eq 20
    end

    it 'e é único' do
      insurance1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                            registration_number: '00000232145203')
      insurance2 = InsuranceCompany.create!(name: 'Seguradora B', email_domain: 'seguradorab.com.br',
                                            registration_number: '02585232145203')

      expect(insurance1.token).not_to eq insurance2.token
    end
  end
end
