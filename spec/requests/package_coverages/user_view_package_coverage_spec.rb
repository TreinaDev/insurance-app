require 'rails_helper'

describe 'Usuário visualiza coberturas' do
  it 'e não está logado' do
    get(package_coverages_path)

    expect(response).to redirect_to(user_session_path)
  end
end

describe 'Usuário acessar detalhes de cobertura' do
  it 'e não está logado' do
    package_coverage = PackageCoverage.create!(name: 'Molhar',
                                               description: 'Assistência por danificação devido a molhar o aparelho.',
                                               status: :active, code: 'ZK3')

    get "/package_coverages/#{package_coverage.id}"

    expect(response).to redirect_to(user_session_path)
  end
end
