require 'rails_helper'

describe 'Insurance Company API' do
  context 'GET /api/v1/insurance_companies' do
    it 'com successo' do
      InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', cnpj: '00000000000000')
      InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br', cnpj: '00000000000001')
      InsuranceCompany.create!(name: 'Seguradora B', email_domain: 'seguradorab.com.br', cnpj: '00000000000002')

      get '/api/v1/insurance_companies'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first['name']).to eq 'Seguradora A'
      expect(json_response.first['email_domain']).to eq 'seguradoraa.com.br'
      expect(json_response.first['cnpj']).to eq '00000000000001'
      expect(json_response.last['name']).to eq 'Seguradora B'
      expect(json_response.last['email_domain']).to eq 'seguradorab.com.br'
      expect(json_response.last['cnpj']).to eq '00000000000002'
    end

    it 'retorna vazio se não existem seguradoras cadastradas' do
      InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', cnpj: '00000000000000')

      get '/api/v1/insurance_companies'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
end
