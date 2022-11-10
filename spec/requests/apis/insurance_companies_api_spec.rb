require 'rails_helper'

describe 'InsuranceCompany API' do
  context 'GET /api/v1/insurance_companies' do
    it 'list all insurance companies ordered by name' do
      InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                               company_status: 1, registration_number: '84157841000105')
      InsuranceCompany.create!(name: 'Prata Seguros', email_domain: 'prataseguros.com.br',
                               registration_number: '31257841000105')
      InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br',
                               registration_number: '99157841000105')

      get '/api/v1/insurance_companies'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Porto Seguro'
      expect(json_response[1]['name']).to eq 'Prata Seguros'
    end
  end
end

