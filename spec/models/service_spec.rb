require 'rails_helper'

RSpec.describe Service, type: :model do
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
    end
  end
end
