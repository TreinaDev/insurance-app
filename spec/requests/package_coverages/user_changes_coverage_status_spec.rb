require 'rails_helper'

describe 'Usuário altera o status de uma cobertura' do
  context 'para inativa' do
    it 'e não está autenticado' do
      package_coverage = PackageCoverage.create!(name: 'Molhar',
                                                 description: 'Assistência por danificação devido a molhar o aparelho.',
                                                 status: :active)

      post "/package_coverages/#{package_coverage.id}/deactivate/"

      expect(response).to redirect_to(new_user_session_url)
    end

    it 'como funcionário' do
      InsuranceCompany.create!(name: 'Seguradora Anjo', email_domain: 'seguradoraanjo.com.br',
                               registration_number: '05681642000117')
      user = User.create!(name: 'Aline', email: 'Aline@seguradoraanjo.com.br', password: 'password', role: :employee)
      package_coverage = PackageCoverage.create!(name: 'Molhar',
                                                 description: 'Assistência por danificação devido a molhar o aparelho.',
                                                 status: :active)

      login_as user
      post "/package_coverages/#{package_coverage.id}/deactivate/"

      expect(response.status).not_to be 200
    end
  end
end
