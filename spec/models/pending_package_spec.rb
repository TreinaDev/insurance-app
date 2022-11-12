require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#valid?' do
    it 'falso quando o nome fica em branco' do
      first = InsuranceCompany.create!(name: 'Laranja', email_domain: 'laranja.com.br', registration_number:
                                          '02000000258210')
      laptops = ProductCategory.create!(name: 'Laptops')
      pending = PendingPackage.new(name: '', min_period: 12, max_period: 24, insurance_company: first, product_category:
                                  laptops)

      expect(pending.valid?).to eq false
    end

    it 'falso quando o período mínimo fica em branco' do
      insurange = InsuranceCompany.create!(name: 'Laranja', email_domain: 'laranja.com.br', registration_number:
                                          '02000000258210')
      laptops = ProductCategory.create!(name: 'Laptops')
      pending = PendingPackage.new(name: 'PremiumSimple', min_period: '', max_period: 24, insurance_company: insurange,
                                   product_category: laptops)

      expect(pending.valid?).to eq false
    end

    it 'falso quando o período máximo fica em branco' do
      insurange = InsuranceCompany.create!(name: 'Laranja', email_domain: 'laranja.com.br', registration_number:
                                          '02000000258210')
      laptops = ProductCategory.create!(name: 'Laptops')
      pending = PendingPackage.new(name: 'PremiumSimple', min_period: 12, max_period: '', insurance_company: insurange,
                                   product_category: laptops)

      expect(pending.valid?).to eq false
    end

    it 'falso quando a seguradora fica em branco' do
      laptops = ProductCategory.create!(name: 'Laptops')
      pending = PendingPackage.new(name: 'Premium Platinum', min_period: 12, max_period: 24, insurance_company: nil,
                                   product_category: laptops)

      expect(pending.valid?).to eq false
    end

    it 'falso quando a categoria fica em branco' do
      insurange = InsuranceCompany.create!(name: 'Laranja', email_domain: 'laranja.com.br', registration_number:
                                          '02000000258210')
      pending = PendingPackage.new(name: 'Premium Simple', min_period: 12, max_period: 24, insurance_company: insurange,
                                   product_category: nil)

      expect(pending.valid?).to eq false
    end

    it 'falso quando o período mínimo é < que um mês' do
      insurange = InsuranceCompany.create!(name: 'Laranja', email_domain: 'laranja.com.br', registration_number:
                                          '02000000258210')
      laptops = ProductCategory.create!(name: 'Laptops')
      pending = PendingPackage.new(name: 'Premium Simple', min_period: 0, max_period: 24, insurance_company: insurange,
                                   product_category: laptops)

      expect(pending.valid?).to eq false
    end

    it 'falso quando o período máximo é < que o periodo mínimo' do
      insurange = InsuranceCompany.create!(name: 'Laranja', email_domain: 'laranja.com.br', registration_number:
                                          '02000000258210')
      laptops = ProductCategory.create!(name: 'Laptops')
      pending_first = PendingPackage.new(name: 'Premium', min_period: 12, max_period: 11, insurance_company: insurange,
                                         product_category: laptops)
      pending_second = PendingPackage.new(name: 'Premium', min_period: 12, max_period: 12, insurance_company: insurange,
                                          product_category: laptops)

      expect(pending_first.valid?).to eq false
      expect(pending_second.valid?).to eq true
    end
  end
end
