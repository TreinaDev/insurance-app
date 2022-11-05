require 'rails_helper'

RSpec.describe 'Usuário visualiza produtos', type: :request do
  it 'e não está logado' do
    get '/products'

    expect(response).to redirect_to(root_path)
  end
end
