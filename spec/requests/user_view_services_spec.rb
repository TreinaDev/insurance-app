require 'rails_helper'

describe 'Usuário visualiza serviços' do
  it 'e não está autenticado' do
    get(services_path)

    expect(response).to redirect_to(user_session_path)
  end
end

describe 'Usuário acessar detalhes de serviço' do
  it 'e não está logado' do
    service = Service.create!(name: 'Assinatura TV',
                              description: 'Concede 10% de desconto em assinatura.',
                              status: :active, code: 'ZK7')
    get "/package_coverages/#{service.id}"

    expect(response).to redirect_to(user_session_path)
  end
end
