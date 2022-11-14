require 'rails_helper'

describe 'Usuário registra nova cobertura' do
  it 'e não está logado' do
    post '/package_coverages', params: { package_coverage: {name: 'Molhar', description: 'Proteção contra dano por água'} }
  
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'e é funcionário de seguradora' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '80958759000110')
    user = User.create!(name: 'Edna', email: 'edna@empresa.com.br', password: 'password', role: :employee)

    login_as(user)
    post '/package_coverages', params: { package_coverage: {name: 'Molhar', description: 'Proteção contra dano por água'} }
  
    expect(response).to redirect_to(root_path)
  end

  it 'a partir da url e é funcionário de seguradora' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '80958759000110')
    user = User.create!(name: 'Edna', email: 'edna@empresa.com.br', password: 'password', role: :employee)

    login_as(user)
    get(new_package_coverage_path)
  
    expect(response).to redirect_to(root_path)
  end
end