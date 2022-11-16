require 'rails_helper'

describe 'Usuário visualiza coberturas' do
  it 'e não está logado' do
    get(package_coverages_path)

    expect(response).to redirect_to(user_session_path)
  end
end
