require 'rails_helper'

describe 'Usuário visualiza serviços' do
  it 'e não está autenticado' do
    get(services_path)

    expect(response).to redirect_to(user_session_path)
  end
end
