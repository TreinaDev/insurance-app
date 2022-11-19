require 'rails_helper'
describe 'Service API' do
  context 'GET /api/v1/services' do
    it 'listar todos os serviços ordenados pelo nome' do
      Service.create!(name: 'Assinatura TV',
                      description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.',
                      status: :active)

      allow(SecureRandom).to receive(:alphanumeric).and_return('AAA')
      Service.create!(name: 'Desconto clubes seguros',
                      description: 'Concede 10% de desconto em aquisição de seguro veicular.', status: :active)

      get '/api/v1/services'
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Assinatura TV'
      expect(json_response[0]['status']).to eq 'active'
      expect(json_response[1]['name']).to eq 'Desconto clubes seguros'
      expect(json_response[1]['code']).to eq 'AAA'
      expect(json_response[1]['status']).to eq 'active'
      expect(json_response[1]['description']).to eq 'Concede 10% de desconto em aquisição de seguro veicular.'
    end

    it 'Retorna vazio se não existir serviços' do
      get '/api/v1/services'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'e acusa erro interno' do
      allow(Service).to receive(:all).and_raise(ActiveRecord::QueryAborted)

      get '/api/v1/services'

      expect(response).to have_http_status 500
    end
  end
end
