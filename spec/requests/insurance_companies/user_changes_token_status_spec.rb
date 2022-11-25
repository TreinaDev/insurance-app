require 'rails_helper'

RSpec.describe 'Usuário altera status de token de seguradora', type: :request do
  it 'e não está logado' do
    insurance_company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                 registration_number: '80929380000456')

    post "/insurance_companies/#{insurance_company.id}/deactivate_token"

    expect(response).to redirect_to(user_session_path)
  end

  it 'e é funcionário de seguradora' do
    insurance_company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                 registration_number: '80929380000456')
    user = User.create!(name: 'Funcionário', email: 'funcionario@seguradoraa.com.br', password: 'password')

    login_as(user)
    post "/insurance_companies/#{insurance_company.id}/deactivate_token"

    expect(response).to redirect_to(root_path)
  end
end
