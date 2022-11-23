require 'rails_helper'

RSpec.describe Package, type: :model do
  describe '#valid?' do
    it 'falso quando o nome fica em branco' do
      insurance = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                          '01000000123410')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.new(name: '', min_period: 12, max_period: 24, insurance_company: insurance,
                            product_category: smartphones)

      expect(package.valid?).to eq false
    end

    it 'falso quando o período mínimo fica em branco' do
      insurance = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                          '01000000123410')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.new(name: 'Premium', min_period: '', max_period: 24, insurance_company: insurance,
                            product_category: smartphones)

      expect(package.valid?).to eq false
    end

    it 'falso quando o período máximo fica em branco' do
      insurance = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                          '01000000123410')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.new(name: 'Premium', min_period: 12, max_period: '', insurance_company: insurance,
                            product_category: smartphones)

      expect(package.valid?).to eq false
    end

    it 'falso quando o seguradora fica em branco' do
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.new(name: 'Premium', min_period: 12, max_period: 24, insurance_company: nil,
                            product_category: smartphones)

      expect(package.valid?).to eq false
    end

    it 'falso quando a categoria fica em branco' do
      insurance = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                          '01000000123410')
      package = Package.new(name: 'Premium', min_period: 12, max_period: 24, insurance_company: insurance,
                            product_category: nil)

      expect(package.valid?).to eq false
    end

    it 'falso quando o período mínimo é < 1' do
      insurance = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                          '01000000123410')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.new(name: 'Premium', min_period: 0, max_period: 24, insurance_company: insurance,
                            product_category: smartphones)

      expect(package.valid?).to eq false
    end

    it 'falso quando o período máximo é < que o período mínimo' do
      insurance = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                          '01000000123410')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.new(name: 'Premium', min_period: 12, max_period: 11, insurance_company: insurance,
                            product_category: smartphones)

      expect(package.valid?).to eq false
    end

    it 'preço não deve ser maior que 60%' do
      package = Package.new(price: 61)

      package.valid?

      expect(package.errors.include?(:price)).to be true
    end
    it 'preço pode ser igual a 60%' do
      package = Package.new(price: 60)

      package.valid?

      expect(package.errors.include?(:price)).to be false
    end
    it 'preço pode ser igual a 0%' do
      package = Package.new(price: 0)

      package.valid?

      expect(package.errors.include?(:price)).to be false
    end
    it 'preço não deve ser menor que 0%' do
      package = Package.new(price: -1)

      package.valid?

      expect(package.errors.include?(:price)).to be true
    end
  end

  describe '#set_percentage_price' do
    it 'calcula e atribui o preço percentual ao ativar pacote' do
      company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                         registration_number: '80958759000110')
      smartphones = ProductCategory.create!(name: 'Smartphones')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                                product_category: smartphones, status: :pending, price: 0.0)
      coverage1 = PackageCoverage.create!(name: 'Molhar',
                                          description: 'Assistência por danificação devido a molhar o aparelho.')
      CoveragePricing.create!(percentage_price: 0.30, package:, package_coverage: coverage1)
      service1 = Service.create!(name: 'Desconto Petlove',
                                 description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.',
                                 status: :active)
      ServicePricing.create!(percentage_price: 0.15, package:, service: service1)

      expect(package.set_percentage_price).to eq 0.45
    end
  end
end
