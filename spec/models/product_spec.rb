require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#valid?' do
    it 'falso quando o modelo de produto fica em branco' do
      category = ProductCategory.create!(name: 'Smartphones')
      product = Product.new(product_model: '', launch_year: '2016', brand: 'Samsung',
                            price: 1200.00, status: :active, product_category: category)

      expect(product.valid?).to eq false
    end

    it 'falso quando o ano de lançamento fica em branco' do
      category = ProductCategory.create!(name: 'Smartphones')
      product = Product.new(product_model: 'ABCD', launch_year: '', brand: 'Samsung',
                            price: 1200.00, status: :active, product_category: category)

      expect(product.valid?).to eq false
    end

    it 'falso quando a marca fica em branco' do
      category = ProductCategory.create!(name: 'Smartphones')
      product = Product.new(product_model: 'ABCD', launch_year: '2016', brand: '',
                            price: 1200.00, status: :active, product_category: category)

      expect(product.valid?).to eq false
    end

    it 'falso quando o preço fica em branco' do
      category = ProductCategory.create!(name: 'Smartphones')
      product = Product.new(product_model: 'ABCD', launch_year: '2016', brand: 'Samsung',
                            price: '', status: :active, product_category: category)

      expect(product.valid?).to eq false
    end

    it 'falso quando o status fica em branco' do
      category = ProductCategory.create!(name: 'Smartphones')
      product = Product.new(product_model: 'ABCD', launch_year: '2016', brand: 'Samsung',
                            price: 1200.00, status: nil, product_category: category)

      expect(product.valid?).to eq false
    end

    it 'falso quando a categoria fica em branco' do
      product = Product.new(product_model: 'ABCD', launch_year: '2016', brand: 'Samsung',
                            price: 1200.00, status: :active, product_category: nil)

      expect(product.valid?).to eq false
    end

    it 'falso se ano não é número' do
      category = ProductCategory.create!(name: 'Smartphones')
      product = Product.new(product_model: 'ABCD', launch_year: 'a123', brand: 'Samsung',
                            price: 1200.00, status: :active, product_category: category)

      expect(product.valid?).to eq false
    end

    it 'falso se ano for diferente de quatro caracteres' do
      category = ProductCategory.create!(name: 'Smartphones')
      product = Product.new(product_model: 'ABCD', launch_year: '20165', brand: 'Samsung',
                            price: 1200.00, status: :active, product_category: category)

      expect(product.valid?).to eq false
    end
  end
end
