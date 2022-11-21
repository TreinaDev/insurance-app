require 'rails_helper'

describe 'Usuário adicionar uma cobertura a um pacote' do
  it 'e não está autenticado' do
    company = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    category = ProductCategory.create!(name: 'Smartphones')
    package =  Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                               product_category: category, status: :pending)
    coverage = PackageCoverage.create!(name: 'Molhar',
                                       description: 'Assistência por danificação devido a molhar o aparelho.')

    post(package_coverage_pricings_path(package.id), params: { coverage_pricing: { percentage_price: 0.3,
                                                                                   package:,
                                                                                   package_coverage: coverage } })

    expect(response).to redirect_to(user_session_path)
    expect(package.coverage_pricings.length).to eq(0)
  end
end
