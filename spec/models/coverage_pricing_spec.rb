require 'rails_helper'

RSpec.describe CoveragePricing, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'true when information complete' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        coverage1 = PackageCoverage.create!(name: 'Molhar',
                                   description: 'Assistencia por danificação devido a molhar o aparelho.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        cp = CoveragePricing.new(status: :active, percentage_price: 0.2, package: package1, package_coverage: coverage1)

        result = cp.valid?

        expect(result).to be true
      end
    end
  end
end
