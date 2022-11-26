require 'rails_helper'

describe 'Find Company for Employee API' do
  context 'GET api/v1/insurance_companies/query?id=pessoa@email.com' do
    it 'com sucesso' do
      InsuranceCompany.create!(name: 'Liga de Seguros', email_domain: 'ligadeseguros.com.br',
                               registration_number: '01333288000189', company_status: :active)

      get '/api/v1/insurance_companies/query?id=pessoa@ligadeseguros.com.br'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'Liga de Seguros'
      expect(json_response['email_domain']).to eq 'ligadeseguros.com.br'
      expect(json_response['registration_number']).to eq '01333288000189'
      expect(json_response['company_status']).to eq 'active'
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'e a Seguradora não está ativa' do
      InsuranceCompany.create!(name: 'Liga de Seguros', email_domain: 'ligadeseguros.com.br',
                               registration_number: '01333288000189', company_status: :inactive)

      get '/api/v1/insurance_companies/query?id=pessoa@ligadeseguros.com.br'

      expect(response.status).to eq 404
    end

    it 'e o token da Seguradora não está ativo' do
      InsuranceCompany.create!(name: 'Liga de Seguros', email_domain: 'ligadeseguros.com.br',
                               registration_number: '01333288000189', company_status: :active,
                               token_status: :token_inactive)

      get '/api/v1/insurance_companies/query?id=pessoa@ligadeseguros.com.br'

      expect(response.status).to eq 404
    end

    it 'e não encontra uma Seguradora' do
      InsuranceCompany.create!(name: 'Liga de Seguros', email_domain: 'ligadeseguros.com.br',
                               registration_number: '01333288000189', company_status: :active)

      get '/api/v1/insurance_companies/query?id=pessoa@seguradora.com.br'

      expect(response.status).to eq 404
    end
  end
end
