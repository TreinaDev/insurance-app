require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  describe '#valid?' do
    it 'falso quando o nome está em branco' do
      product_category = ProductCategory.new(name: '')

      result = product_category.valid?

      expect(result).to eq false
    end

    it 'falso quando o nome está em uso' do
      ProductCategory.create!(name: 'TV')
      product_category = ProductCategory.new(name: 'TV')

      result = product_category.valid?

      expect(result).to eq false
    end

    it 'falso quando o nome já está em uso para uma outra formatação' do
      ProductCategory.create!(name: 'tv')
      product_category = ProductCategory.new(name: 'TV')

      result = product_category.valid?

      expect(result).to eq false
    end
  end
end
