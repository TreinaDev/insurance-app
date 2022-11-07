# require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when product_model is empty' do
        product_category = ProductCategory.create!(name: 'TV')
        product = Product.create(product_model: '', launch_year: '2022', brand: 'LG',
                  price: 5000, product_category_id: product_category.id)

        result = product.valid?

        expect(result).to eq false
      end

      it 'false when launch_year is empty' do
        product_category = ProductCategory.create!(name: 'TV')
        product = Product.create(product_model: 'TV 32', launch_year: '', brand: 'LG',
                  price: 5000, product_category_id: product_category.id)

        result = product.valid?

        expect(result).to eq false
      end

      it 'false when brand is empty' do
        product_category = ProductCategory.create!(name: 'TV')
        product = Product.create(product_model: 'TV 32', launch_year: '2022', brand: '',
                  price: 5000, product_category_id: product_category.id)

        result = product.valid?

        expect(result).to eq false
      end

      it 'false when price is empty' do
        product_category = ProductCategory.create!(name: 'TV')
        product = Product.create(product_model: 'TV 32', launch_year: '2022', brand: 'LG',
                  price: '', product_category_id: product_category.id)

        result = product.valid?

        expect(result).to eq false
      end

      it 'false when product_category_id is nil' do
        product = Product.create(product_model: 'TV 32', launch_year: '2022', brand: 'LG',
                  price: '', product_category_id: nil)

        result = product.valid?

        expect(result).to eq false
      end
    end

    context 'numericality' do
      it 'price must be greater than 0' do
        product_category = ProductCategory.create!(name: 'TV')
        product = Product.create(product_model: 'TV 32', launch_year: '2022', brand: 'LG',
                  price: 0, product_category_id: product_category.id)

        result = product.valid?

        expect(result).to eq false
      end      
    end
  end
end
