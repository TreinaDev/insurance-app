require 'rails_helper'

describe 'ProductCategory API' do
  context 'GET api/v1/product_categories' do
    it 'com sucesso' do
      ProductCategory.create!(name: 'TVs')
      ProductCategory.create!(name: 'Smartphones')
      ProductCategory.create!(name: 'Desktops')

      get '/api/v1/product_categories'

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response[0]['name']).to eq 'Desktops'
      expect(json_response[1]['name']).to eq 'Smartphones'
      expect(json_response[2]['name']).to eq 'TVs'
    end

    it 'retorna vazio se não há categorias' do
      get '/api/v1/product_categories'

      expect(response).to have_http_status 200
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'e ocorre erro interno' do
      allow(ProductCategory).to receive(:all).and_raise(ActiveRecord::QueryAborted)

      get '/api/v1/product_categories'

      expect(response).to have_http_status 500
    end
  end

  context 'GET api/v1/product_categories/products' do
    it 'com sucesso' do
      product_category_a = ProductCategory.create!(name: 'TVs')
      ProductCategory.create!(name: 'Smartphones')
      Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG',
                      price: 5000, product_category: product_category_a)
      Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'SAMSUNG',
                      price: 8000, product_category: product_category_a)

      get "/api/v1/product_categories/#{product_category_a.id}/products"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response[0]['product_model']).to eq 'TV 32'
      expect(json_response[1]['product_model']).to eq 'TV 50'
    end

    it 'e não há produtos cadastrados em categoria' do
      product_category = ProductCategory.create!(name: 'TVs')

      get "/api/v1/product_categories/#{product_category.id}/products"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'e categoria de produto não existe' do
      get "/api/v1/product_categories/666/products"

      expect(response).to have_http_status 404
    end
  end
end
