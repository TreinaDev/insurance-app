require 'rails_helper'

describe 'InsuranceCompany API' do
  context 'GET /api/v1/insurance_companies' do
    it 'lista todas as seguradoras ordenadas pelo nome' do
      InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                               company_status: 1, registration_number: '84157841000105')
      InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br',
                               registration_number: '99157841000105')
      InsuranceCompany.create!(name: 'Trata Seguros', email_domain: 'trataseguros.com.br',
                               registration_number: '31257841000105')

      get '/api/v1/insurance_companies'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 3
      expect(json_response[0]['name']).to eq 'Allianz Seguros'
      expect(json_response[1]['name']).to eq 'Porto Seguro'
      expect(json_response[2]['name']).to eq 'Trata Seguros'
    end

    it 'retorna uma lista vazia se não houver seguradoras' do
      get '/api/v1/insurance_companies'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 0
    end

    it 'and raise internal error' do
      allow(InsuranceCompany).to receive(:all).and_raise(ActiveRecord::QueryAborted)

      get '/api/v1/insurance_companies'

      expect(response).to have_http_status 500
    end
  end

  context 'GET api/v1/insurance_companies/1' do
    it 'e retorna detalhes da seguradora' do
      InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br',
                               registration_number: '99157841000105')
      insurance_company = InsuranceCompany.create!(name: 'Trata Seguros', email_domain: 'trataseguros.com.br',
                                                   registration_number: '31257841000105')

      get "/api/v1/insurance_companies/#{insurance_company.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'Trata Seguros'
      expect(json_response['email_domain']).to eq 'trataseguros.com.br'
      expect(json_response['registration_number']).to eq '31257841000105'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
      expect(json_response.values).not_to include 'Porto Seguro'
    end

    it 'falha se a seguradora não é encontrada' do
      InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br',
                               registration_number: '99157841000105')

      get '/api/v1/insurance_companies/100'

      expect(response).to have_http_status 404
    end
  end
end
