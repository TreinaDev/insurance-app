require 'rails_helper'

RSpec.describe 'Usuário acessa tela de registro de seguradoras', type: :request do
  it 'e não está logado' do
    get '/insurance_companies/new'

    expect(response).to redirect_to(user_session_path)
  end

  it 'e é funcionário logado' do
    user = User.create!(name: 'Funcionário', email: 'funcionario@seguradoraa.com.br', password: 'password')

    login_as(user)
    get '/insurance_companies/new'

    expect(response).to redirect_to(root_path)
  end
end
