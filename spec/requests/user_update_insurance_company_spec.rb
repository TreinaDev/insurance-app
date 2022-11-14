require 'rails_helper'

RSpec.describe 'Usuário atualiza seguradoras', type: :request do
  it 'e não está logado como admin' do
    ic = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                  registration_number: '80929380000456')
    user = User.create!(name: 'Funcionário', email: 'funcionario@seguradoraa.com.br', password: 'password')

    login_as(user)
    patch(insurance_company_path(ic.id), params: { ic: { name: 'Seguros A' } })

    expect(response).to redirect_to(root_path)
  end
end
