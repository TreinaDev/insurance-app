require 'rails_helper'

describe 'Product API' do
  context 'GET /api/v1/products' do
    it 'list all products ordered by name' do
      product_category = ProductCategory.create!(name: 'TV')
      Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG',
                      price: 5000, product_category_id: product_category.id)
      Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'SAMSUNG',
                      price: 8000, product_category_id: product_category.id)
    
      get '/api/v1/products'
      
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["product_model"]).to eq 'TV 32'
      expect(json_response[1]["product_model"]).to eq 'TV 50'

    end

    it 'return empty if there is no products' do
      get '/api/v1/products'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'and raise internal error' do
      allow(Product).to receive(:all).and_raise(ActiveRecord::QueryAborted)

      get '/api/v1/products'

      expect(response).to have_http_status 500
    end
  end
end
