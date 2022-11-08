require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#active?' do
    it 'o produto é ativo por padrão' do
      product_category = ProductCategory.create!(name: 'Celular')
      product = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                                product_category:)
      
      expect(product.active?).to be true
    end
  end
end
