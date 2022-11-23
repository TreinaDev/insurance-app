require 'rails_helper'

RSpec.describe Policy, type: :model do
  describe 'valid?' do
    it 'falso se não houver nome do cliente' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: '', client_registration_number: '99950033340',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: 1,
                          policy_period: 12, package_id: package.id)

      result = policy.valid?

      expect(result).to be false
    end

    it 'falso se não houver CPF do cliente' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: 1,
                          policy_period: 12, package_id: package.id)

      result = policy.valid?

      expect(result).to be false
    end

    it 'falso se não houver email do cliente' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '99950033340',
                          client_email: '',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: 1,
                          policy_period: 12, package_id: package.id)

      result = policy.valid?

      expect(result).to be false
    end

    it 'falso se não houver id do pedido' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '99950033340',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: insurance_company.id, order_id: '',
                          equipment_id: 1,
                          policy_period: 12, package_id: package.id)

      result = policy.valid?

      expect(result).to be false
    end

    it 'falso se não houver id do equipamento' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '99950033340',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: '', purchase_date: Time.zone.today,
                          policy_period: 12, package_id: package.id)

      result = policy.valid?

      expect(result).to be false
    end

    it 'falso se não houver duração do seguro' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '99950033340',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: 1,
                          policy_period: '', package_id: package.id)

      result = policy.valid?

      expect(result).to be false
    end

    it 'falso se não houver id do pacote' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                      price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '99950033340',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: 1,
                          policy_period: 12, package_id: '')

      result = policy.valid?

      expect(result).to be false
    end

    it 'falso se id do pedido não for um número' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '99950033340',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: insurance_company.id, order_id: 'd',
                          equipment_id: 1,
                          policy_period: 12, package_id: package.id)

      result = policy.valid?

      expect(result).to be false
    end

    it 'falso se id do equipamento não for um número' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '99950033340',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: 'd',
                          policy_period: 12, package_id: package.id)

      result = policy.valid?

      expect(result).to be false
    end

    it 'falso se duração do seguro não for um número' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '99950033340',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: 1,
                          policy_period: 'd', package_id: package.id)

      result = policy.valid?

      expect(result).to be false
    end

    it 'falso se o id do pedido não for único' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      Policy.create!(client_name: 'Maria Alves', client_registration_number: '99950033340',
                     client_email: 'mariaalves@email.com',
                     insurance_company_id: insurance_company.id, order_id: 1,
                     equipment_id: 1,
                     policy_period: 12, package_id: package.id)
      other_policy = Policy.new(client_name: 'Rafael Santos', client_registration_number: '11122233344',
                                client_email: 'rafaelsantos@email.com',
                                insurance_company_id: insurance_company.id, order_id: 1,
                                equipment_id: 2,
                                policy_period: 24, package_id: package.id)

      result = other_policy.valid?

      expect(result).to be false
    end
  end

  describe 'Gera um código aleatório' do
    it 'ao criar uma nova apólice' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '99950033340',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: 1,
                          policy_period: 12, package_id: package.id)

      policy.save!
      result = policy.code

      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end

    it 'e o código é único' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      first_policy = Policy.new(client_name: 'José Antonio', client_registration_number: '77750033340',
                                client_email: 'joseantonio@email.com',
                                insurance_company_id: insurance_company.id, order_id: 1,
                                equipment_id: 1,
                                policy_period: 12, package_id: package.id)
      second_policy = Policy.new(client_name: 'Maria Alves', client_registration_number: '99950033340',
                                 client_email: 'mariaalves@email.com',
                                 insurance_company_id: insurance_company.id, order_id: 2,
                                 equipment_id: 1,
                                 policy_period: 12, package_id: package.id)

      second_policy.save!

      expect(second_policy.code).not_to eq first_policy.code
    end
  end

  describe 'Gera data de validade e de compra automaticamente' do
    it 'ao ativar apólice' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'José Antonio', client_registration_number: '77750033340',
                          client_email: 'joseantonio@email.com',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: 1,
                          policy_period: 12, package_id: package.id)

      policy.active!
      expiration_date = policy.expiration_date.strftime
      purchase_date = policy.purchase_date.strftime

      expect(purchase_date).to eq(Time.zone.today.strftime)
      expect(expiration_date).to eq((Time.zone.today + policy.policy_period.months).strftime)
    end
  end

  describe 'A apólice é pendente' do
    it 'ao ser criada' do
      insurance_company = InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzaeguros.com.br',
                                                   registration_number: '84157841000105')
      product_category = ProductCategory.create!(name: 'TV')
      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company:,
                                price: 9, product_category_id: product_category.id)
      policy = Policy.new(client_name: 'José Antonio', client_registration_number: '77750033340',
                          client_email: 'joseantonio@email.com',
                          insurance_company_id: insurance_company.id, order_id: 1,
                          equipment_id: 1,
                          policy_period: 12, package_id: package.id)

      policy.save!

      expect(policy.status).to eq('pending')
    end
  end
end
