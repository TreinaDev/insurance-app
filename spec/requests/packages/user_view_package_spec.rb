require 'rails_helper'

describe 'Usuário visualiza pacotes' do
  it 'e não está autenticado' do
    get(packages_path)

    expect(response).to redirect_to(user_session_path)
  end
end
