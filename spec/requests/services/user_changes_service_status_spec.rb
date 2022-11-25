require 'rails_helper'

describe 'Usuário altera o status de um serviço' do
  context 'para inativo' do
    it 'e não está autenticado' do
      service = Service.create!(name: 'Assinatura TV',
                                description: 'Concede 10% de desconto em assinatura.',
                                status: :active, code: 'ZK7')

      post "/services/#{service.id}/deactivate/"

      expect(response).to redirect_to(new_user_session_url)
    end

    it 'como funcionário' do
      InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                               registration_number: '05681642000117')
      user = User.create!(name: 'Aline', email: 'Aline@seguradoraa.com.br', password: 'password', role: :employee)
      service = Service.create!(name: 'Assinatura TV',
                                description: 'Concede 10% de desconto em assinatura.',
                                status: :active, code: 'ZK7')

      login_as user
      post "/services/#{service.id}/deactivate/"

      expect(response.status).not_to be 200
    end
  end
end
