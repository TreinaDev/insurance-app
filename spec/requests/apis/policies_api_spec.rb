require 'rails_helper'

describe 'Policy API' do
  context 'POST /api/v1/policies' do
    it 'com sucesso' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 90.00, product_category:)
      policy_params = { policy: { client_name: 'Maria Alves', client_registration_number: '99950033340',
                                  client_email: 'mariaalves@email.com',
                                  insurance_company_id: insurance_company.id, order_id: 1,
                                  equipment_id: 1, purchase_date: Time.zone.today,
                                  policy_period: 12, package_id: package.id } }

      post '/api/v1/policies', params: policy_params

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response['client_name']).to eq 'Maria Alves'
      expect(json_response['client_registration_number']).to eq '99950033340'
      expect(json_response['client_email']).to eq 'mariaalves@email.com'
      expect(json_response['insurance_company_id']).to eq insurance_company.id
      expect(json_response['order_id']).to eq 1
      expect(json_response['equipment_id']).to eq 1
      expect(json_response['purchase_date']).to eq Time.zone.today.strftime
      expect(json_response['policy_period']).to eq 12
      expect(json_response['package_id']).to eq package.id
      expect(json_response['expiration_date']).to eq (Time.zone.today + 12.months).strftime
    end

    it 'falha se parâmetros estão incompletos' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 90.00, product_category:)
      policy_params = { policy: { client_name: 'Maria Alves', client_registration_number: '99950033340',
                                  client_email: '',
                                  insurance_company_id: insurance_company.id, order_id: '',
                                  equipment_id: 1, purchase_date: Time.zone.today,
                                  policy_period: '', package_id: package.id } }

      post '/api/v1/policies', params: policy_params

      expect(response).to have_http_status(412)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('E-mail do Cliente não pode ficar em branco')
      expect(response.body).to include('Pedido não pode ficar em branco')
      expect(response.body).to include('Prazo de Contratação não pode ficar em branco')
    end

    it 'falha se houver erro interno' do
      allow(Policy).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 90.00, product_category:)
      policy_params = { policy: { client_name: 'Maria Alves', client_registration_number: '99950033340',
                                  client_email: 'mariaalves@email.com',
                                  insurance_company_id: insurance_company.id, order_id: 1,
                                  equipment_id: 1, purchase_date: Time.zone.today,
                                  policy_period: 12, package_id: package.id } }

      post '/api/v1/policies', params: policy_params

      expect(response).to have_http_status(500)
    end
  end
end
