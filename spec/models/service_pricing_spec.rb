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
                                    assinatura com mais canais disponíveis no mercado.', status: :active)
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: :active, percentage_price: 0.2, package: package1, service: service1)

        result = sp.valid?

        expect(result).to be true
      end

      it 'falso se pacote nulo' do
        service1 = Service.create!(name: 'Assinatura TV',
                                   description: 'Consede 10% de desconto em
                                    assinatura com mais canais disponíveis no mercado.', status: :active)
        sp = ServicePricing.new(status: :active, percentage_price: 0.2, package: nil, service: service1)

        result = sp.valid?

        expect(result).to be false
      end

      it 'falso se serviço nulo' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
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
                                    assinatura com mais canais disponíveis no mercado.', status: :active)
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
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
                                    assinatura com mais canais disponíveis no mercado.', status: :active)
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
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
                                    assinatura com mais canais disponíveis no mercado.', status: :active)
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
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
                                    assinatura com mais canais disponíveis no mercado.', status: :active)
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: :active, percentage_price: 30.1, package: package1, service: service1)

        result = sp.valid?

        expect(result).to be false
      end
    end

    context '#activeService' do
      it 'falso para serviço inativo' do
        isurance_company1 = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                                     registration_number: '80929380000456')
        product_category = ProductCategory.create!(name: 'Smartphone')
        service1 = Service.create!(name: 'Assinatura TV',
                                   description: 'Consede 10% de desconto em
                                    assinatura com mais canais disponíveis no mercado.', status: :inactive)
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3, price: 0.0,
                                   insurance_company: isurance_company1, product_category_id: product_category.id)
        sp = ServicePricing.new(status: :active, percentage_price: 0.2, package: package1, service: service1)

        result = sp.valid?

        expect(result).to be false
      end
    end

    context 'uniqueness' do
      it 'falso quando o serviço já foi usado no pacote' do
        company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                           registration_number: '80929380000456')
        category = ProductCategory.create!(name: 'Smartphone')
        service1 = Service.create!(name: 'Desconto Petlove',
                                   description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.',
                                   status: :active)
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: company, price: 0.0,
                                   product_category: category)
        ServicePricing.create!(percentage_price: 0.15, package: package1, service: service1)
        sp = ServicePricing.new(percentage_price: 0.20, package: package1, service: service1)

        expect(sp.valid?).to be false
      end

      it 'verdadeiro quando o serviço já foi usado em outro pacote' do
        company = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                           registration_number: '80929380000456')
        category = ProductCategory.create!(name: 'Smartphone')
        service1 = Service.create!(name: 'Desconto Petlove',
                                   description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.',
                                   status: :active)
        package1 = Package.create!(name: 'Seguro Completo', max_period: 12, min_period: 3,
                                   insurance_company: company, price: 0.0,
                                   product_category: category)
        package2 = Package.create!(name: 'Seguro Extra', max_period: 11, min_period: 4,
                                   insurance_company: company, price: 0.0,
                                   product_category: category)
        ServicePricing.create!(percentage_price: 0.15, package: package1, service: service1)
        sp = ServicePricing.new(percentage_price: 0.15, package: package2, service: service1)

        expect(sp.valid?).to be true
      end
    end
  end
end
