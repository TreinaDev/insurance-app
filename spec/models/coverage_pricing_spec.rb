require 'rails_helper'

RSpec.describe CoveragePricing, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'verdadeiro quando informação completa' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        coverage1 = PackageCoverage.create!(name: 'Molhar',
                                            description: 'Assistencia por danificação devido a molhar o aparelho.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        cp = CoveragePricing.new(status: :active, percentage_price: 0.2, package: package1, package_coverage: coverage1)

        result = cp.valid?

        expect(result).to be true
      end

      it 'falso quando status nulo' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        coverage1 = PackageCoverage.create!(name: 'Molhar',
                                            description: 'Assistencia por danificação devido a molhar o aparelho.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        cp = CoveragePricing.new(status: nil, percentage_price: 0.2, package: package1, package_coverage: coverage1)

        result = cp.valid?

        expect(result).to be false
      end

      it 'falso quando preço percentual está vazio' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        coverage1 = PackageCoverage.create!(name: 'Molhar',
                                            description: 'Assistencia por danificação devido a molhar o aparelho.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        cp = CoveragePricing.new(status: :active, percentage_price: '', package: package1, package_coverage: coverage1)

        result = cp.valid?

        expect(result).to be false
      end

      it 'falso quando pacote é nulo' do
        coverage1 = PackageCoverage.create!(name: 'Molhar',
                                            description: 'Assistencia por danificação devido a molhar o aparelho.')
        cp = CoveragePricing.new(status: :active, percentage_price: 0.2, package: nil, package_coverage: coverage1)

        result = cp.valid?

        expect(result).to be false
      end

      it 'falso quando cobertura é nula' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        PackageCoverage.create!(name: 'Molhar',
                                description: 'Assistencia por danificação devido a molhar o aparelho.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        cp = CoveragePricing.new(status: :active, percentage_price: 0.2, package: package1,
                                 package_coverage: nil)

        result = cp.valid?

        expect(result).to be false
      end
    end

    context '#numericality' do
      it 'falso se preço percentual negativo' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        coverage1 = PackageCoverage.create!(name: 'Molhar',
                                            description: 'Assistencia por danificação devido a molhar o aparelho.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        cp = CoveragePricing.new(status: :active, percentage_price: -0.2, package: package1,
                                 package_coverage: coverage1)

        result = cp.valid?

        expect(result).to be false
      end

      it 'falso se preço percentual acima de 30' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        coverage1 = PackageCoverage.create!(name: 'Molhar',
                                            description: 'Assistencia por danificação devido a molhar o aparelho.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: isurance_company1,
                                   product_category_id: product_category.id)
        cp = CoveragePricing.new(status: :active, percentage_price: 30.2, package: package1,
                                 package_coverage: coverage1)

        result = cp.valid?

        expect(result).to be false
      end
    end
    context '#activePackageCoverage' do
      it 'falso para cobertura inativa' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        coverage1 = PackageCoverage.create!(name: 'Molhar',
                                            description: 'Assistencia por danificação devido a molhar o aparelho.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: isurance_company1,
                                   product_category_id: product_category.id)
        cp = CoveragePricing.new(status: :inactive, percentage_price: 30.2, package: package1,
                                 package_coverage: coverage1)

        result = cp.valid?

        expect(result).to be false
      end
    end
    context 'uniqueness' do
      it 'falso quando a cobertura já foi usada no pacote' do
        company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                           registration_number: '80929380000456')
        category = ProductCategory.create!(name: 'Smartphone')
        coverage1 = PackageCoverage.create!(name: 'Molhar',
                                            description: 'Assistencia por danificação devido a molhar o aparelho.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: company,
                                   product_category: category)
        CoveragePricing.create!(percentage_price: 0.3, package: package1, package_coverage: coverage1)
        cp = CoveragePricing.new(percentage_price: 0.4, package: package1, package_coverage: coverage1)

        expect(cp.valid?).to be false
      end

      it 'verdadeiro quando a cobertura já foi usada em outro pacote' do
        company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                           registration_number: '80929380000456')
        category = ProductCategory.create!(name: 'Smartphone')
        coverage1 = PackageCoverage.create!(name: 'Molhar',
                                            description: 'Assistencia por danificação devido a molhar o aparelho.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: company, price: 0.0,
                                   product_category: category)
        package2 = Package.create!(name: 'Seguro Extra', max_period: 11, min_period: 4,
                                   insurance_company: company, price: 0.0,
                                   product_category: category)
        CoveragePricing.create!(percentage_price: 0.3, package: package1, package_coverage: coverage1)
        cp = CoveragePricing.new(percentage_price: 0.3, package: package2, package_coverage: coverage1)

        expect(cp.valid?).to be true
      end
    end
  end
end
