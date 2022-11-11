require 'rails_helper'

RSpec.describe ServicePricing, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'true when information complete' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        service1 = Service.create!(name: 'Assinatura TV',
                                   description: 'Consede 10% de desconto em
                                    assinatura com mais canais disponíveis no mercado.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: :active, percentage_price: 0.2, package: package1, service: service1)

        result = sp.valid?

        expect(result).to be true
      end

      it 'false when package is null' do
        service1 = Service.create!(name: 'Assinatura TV',
                                   description: 'Consede 10% de desconto em
                                    assinatura com mais canais disponíveis no mercado.')
        sp = ServicePricing.new(status: :active, percentage_price: 0.2, package: nil , service: service1)

        result = sp.valid?

        expect(result).to be false
      end

      it 'false when service is null' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: :active, percentage_price: 0.2, package: package1, service: nil)

        result = sp.valid?

        expect(result).to be false
      end

      it 'false when status is null' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        service1 = Service.create!(name: 'Assinatura TV',
                                   description: 'Consede 10% de desconto em
                                    assinatura com mais canais disponíveis no mercado.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: nil, percentage_price: 0.2, package: package1, service: service1)

        result = sp.valid?

        expect(result).to be false
      end

      it 'false when percentage price is empty' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        service1 = Service.create!(name: 'Assinatura TV',
                                   description: 'Consede 10% de desconto em
                                    assinatura com mais canais disponíveis no mercado.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: :active, percentage_price: '', package: package1, service: service1)

        result = sp.valid?

        expect(result).to be false
      end
    end

    context '#numericality' do
      it 'false when percentage price is negative' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        service1 = Service.create!(name: 'Assinatura TV',
                                   description: 'Consede 10% de desconto em
                                    assinatura com mais canais disponíveis no mercado.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: :active, percentage_price: -0.2, package: package1, service: service1)

        result = sp.valid?

        expect(result).to be false
      end

      it 'false when percentage price is greater than 1' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        service1 = Service.create!(name: 'Assinatura TV',
                                   description: 'Consede 10% de desconto em
                                    assinatura com mais canais disponíveis no mercado.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: :active, percentage_price: 2, package: package1, service: service1)

        result = sp.valid?

        expect(result).to be false
      end
    end
  end
end
