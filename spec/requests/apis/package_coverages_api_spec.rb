require 'rails_helper'
describe 'Product API' do
  context 'GET /api/v1/package_coverages' do
    it 'listar todas as coberturas ordenadas pelo nome' do
      PackageCoverage.create!(name: 'Molhar',
                              description: 'Assistência por danificação devido a molhar o aparelho.')
      PackageCoverage.create!(name: 'Quebra de tela',
                              description: 'Assistência por danificação da tela do aparelho.')

      get '/api/v1/package_coverages'
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Molhar'
      expect(json_response[1]['name']).to eq 'Quebra de tela'
    end
    it 'Retorna vazio se não existir coberturas' do
      get '/api/v1/package_coverages'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'e acusa erro interno' do
      allow(PackageCoverage).to receive(:all).and_raise(ActiveRecord::QueryAborted)

      get '/api/v1/package_coverages'

      expect(response).to have_http_status 500
    end
  end
end
