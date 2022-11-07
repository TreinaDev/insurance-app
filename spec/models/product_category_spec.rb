require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  describe '#valid?' do
    it 'false when name is empty' do
      product_category = ProductCategory.new(name: '')

      result = product_category.valid?

      expect(result).to eq false
    end

    it 'false when name is already in use' do
      ProductCategory.create!(name: 'TV')
      product_category = ProductCategory.new(name: 'TV')

      result = product_category.valid?

      expect(result).to eq false
    end

    it 'false when name is already in use for case sensitive' do
      ProductCategory.create!(name: 'tv')
      product_category = ProductCategory.new(name: 'TV')

      result = product_category.valid?

      expect(result).to eq false
    end
  end
end
