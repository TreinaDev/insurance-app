require 'rails_helper'

RSpec.describe PackageCoverage, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'verdadeiro para informação completa' do
        pc = PackageCoverage.new(name: 'Molhar',
                                 description: 'Assistência por danificação devido a molhar o aparelho.')

        result = pc.valid?

        expect(result).to be true
      end

      it 'falso para nome em branco' do
        pc = PackageCoverage.new(name: '',
                                 description: 'Assistência por danificação devido a molhar o aparelho.')

        result = pc.valid?

        expect(result).to be false
      end

      it 'falso para descrição em branco' do
        pc = PackageCoverage.new(name: 'Molhar', description: '')

        result = pc.valid?

        expect(result).to be false
      end

      it 'falso quando código é nulo' do
        allow(SecureRandom).to receive(:alphanumeric).and_return('')
        pc = PackageCoverage.new(name: 'Molhar',
                                 description: 'Assistência por danificação devido a molhar o aparelho.',
                                 status: :active)

        result = pc.valid?

        expect(result).to eq false
      end
    end

    context '#length' do
      it 'falso para descrição com menos de 3 caracteres' do
        pc = PackageCoverage.new(name: 'Molhar', description: 'As')

        result = pc.valid?

        expect(result).to be false
      end
    end

    context '#uniqueness' do
      it 'falso para nome já cadastrado' do
        PackageCoverage.create!(name: 'Molhar',
                                description: 'Assistência por naufrágio do aparelho.')
        pc = PackageCoverage.new(name: 'Molhar',
                                 description: 'Assistência por danificação devido a molhar o
                                 aparelho.')

        result = pc.valid?

        expect(result).to be false
      end

      it 'falso quando código não é único' do
        allow(SecureRandom).to receive(:alphanumeric).and_return('AAA')
        PackageCoverage.create!(name: 'Quebra de tela',
                                description: 'Assistência por danificação da tela do aparelho.')
        pc = PackageCoverage.new(name: 'Molhar',
                                 description: 'Assistência por danificação devido a molhar o aparelho.',
                                 status: :active)

        result = pc.valid?

        expect(result).to eq false
      end
    end
  end
end
