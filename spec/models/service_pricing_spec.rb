require 'rails_helper'

RSpec.describe ServicePricing, type: :model do
  describe '#valid?' do
    context 'presença' do
      it 'verdadeiro para informação completa' do
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

      it 'falso se pacote nulo' do
        service1 = Service.create!(name: 'Assinatura TV',
                                   description: 'Consede 10% de desconto em
                                    assinatura com mais canais disponíveis no mercado.')
        sp = ServicePricing.new(status: :active, percentage_price: 0.2, package: nil, service: service1)

        result = sp.valid?

        expect(result).to be false
      end

      it 'falso se serviço nulo' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: :active, percentage_price: 0.2, package: package1, service: nil)

        result = sp.valid?

        expect(result).to be false
      end

      it 'falso se status nulo' do
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

      it 'falso se preço percentual vazio' do
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
      it 'falso se preço percentual negativo' do
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

      it 'falso quando preço percentual é maior que 30' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        service1 = Service.create!(name: 'Assinatura TV',
                                   description: 'Consede 10% de desconto em
                                    assinatura com mais canais disponíveis no mercado.')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: :active, percentage_price: 30.1, package: package1, service: service1)

        result = sp.valid?

        expect(result).to be false
      end
    end
  end
end
