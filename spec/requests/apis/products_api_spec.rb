require 'rails_helper'

describe 'Product API' do
  context 'GET /api/v1/products' do
    it 'lista todos os produtos ordeandos pelo nome' do
      product_category = ProductCategory.create!(name: 'TV')
      producta = Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG',
                                 price: 5000, product_category_id: product_category.id)
      Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'SAMSUNG',
                      price: 8000, product_category_id: product_category.id)
      image_path = Rails.root.join('spec/support/images/tv32.jpeg')
      producta.image.attach(io: image_path.open, filename: 'tv32.jpeg')

      get '/api/v1/products'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['product_model']).to eq 'TV 32'
      expect(json_response[1]['product_model']).to eq 'TV 50'
      expect(json_response[0].keys).to include('image_url')
    end

    it 'retorna vazio se não houver produtos' do
      get '/api/v1/products'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'e acusa erro interno' do
      allow(Product).to receive(:all).and_raise(ActiveRecord::QueryAborted)

      get '/api/v1/products'

      expect(response).to have_http_status 500
    end
  end

  context 'GET /api/v1/products/1' do
    it 'sucesso' do
      product_category = ProductCategory.create!(name: 'TV')
      product = Product.create!(product_model: 'TV 32', launch_year: '2022',
                                brand: 'LG', price: 5000, product_category_id: product_category.id)
      image_path = Rails.root.join('spec/support/images/tv32.jpeg')
      product.image.attach(io: image_path.open, filename: 'tv32.jpeg')

      get "/api/v1/products/#{product.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['product_model']).to eq('TV 32')
      expect(json_response['launch_year']).to eq('2022')
      expect(json_response['brand']).to eq('LG')
      expect(json_response['price']).to eq '5000.0'
      expect(json_response.keys).to include('image_url')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'falha se o produto não for encontrado' do
      get '/api/v1/products/3333'

      expect(response.status).to eq 404
    end
  end
end
