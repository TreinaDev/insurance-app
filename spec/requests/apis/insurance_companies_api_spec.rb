require 'rails_helper'

describe 'InsuranceCompany API' do
  context 'GET /api/v1/insurance_companies' do
    it 'lista todas as seguradoras ordenadas pelo nome' do
      insurance_a = InsuranceCompany.create!(name: 'Liga de Seguros', email_domain: 'ligadeseguros.com.br',
                                             registration_number: '01333288000189')
      logo_path = Rails.root.join('spec/support/logos/liga_seguros.PNG')
      insurance_a.logo.attach(io: logo_path.open, filename: 'liga_seguros.PNG')
      insurance_b = InsuranceCompany.create!(name: 'Trapiche Seguro', email_domain: 'trapicheseguro.com.br',
                                             registration_number: '29929380000125', company_status: 1)
      logo_path = Rails.root.join('spec/support/logos/trapiche_seguro.PNG')
      insurance_b.logo.attach(io: logo_path.open, filename: 'trapiche_seguro.PNG')
      insurance_c = InsuranceCompany.create!(name: 'Anjo Seguradora', email_domain: 'anjoseguradora.com.br',
                                             registration_number: '90929380000777')
      logo_path = Rails.root.join('spec/support/logos/anjo_seguradora.PNG')
      insurance_c.logo.attach(io: logo_path.open, filename: 'anjo_seguradora.PNG')

      get '/api/v1/insurance_companies'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 3
      expect(json_response[0]['name']).to eq 'Anjo Seguradora'
      expect(json_response[1]['name']).to eq 'Liga de Seguros'
      expect(json_response[2]['name']).to eq 'Trapiche Seguro'
      expect(json_response[0].keys).to include 'logo_url'
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
      insurance_company = InsuranceCompany.create!(name: 'Liga de Seguros', email_domain: 'ligadeseguros.com.br',
                                                   registration_number: '01333288000189')
      logo_path = Rails.root.join('spec/support/logos/liga_seguros.PNG')
      insurance_company.logo.attach(io: logo_path.open, filename: 'liga_seguros.PNG')

      get "/api/v1/insurance_companies/#{insurance_company.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'Liga de Seguros'
      expect(json_response['email_domain']).to eq 'ligadeseguros.com.br'
      expect(json_response['registration_number']).to eq '01333288000189'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
      expect(json_response.keys).to include 'logo_url'
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
