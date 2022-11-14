require 'rails_helper'

RSpec.describe Service, type: :model do
  describe '#valid?' do
    it 'falso quando o nome fica em branco' do
      service = Service.new(name: '',
                            description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')

      expect(service.valid?).to eq false
    end

    it 'falso quando a descrição fica em branco' do
      service = Service.new(name: 'Assinatura TV',
                            description: '')

      expect(service.valid?).to eq false
    end

    it 'falso quando o nome já está em uso' do
      Service.create!(name: 'Assinatura TV',
                      description: 'Concede um mês grátis em assinatura do netflix.')
      service = Service.new(name: 'Assinatura TV',
                            description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')

      expect(service.valid?).to eq false
    end

    it 'falso quando a descrição for menor que 3 caracteres' do
      service = Service.new(name: 'Assinatura TV',
                            description: 'Co')

      expect(service.valid?).to eq false
    end
  end
end
