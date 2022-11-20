require 'rails_helper'

describe 'Usuário altera status da apólice' do
  context 'como funcionário' do
    it 'para pagamento pendente' do
      insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                   registration_number: '84157841000105')
      user = User.create!(email: 'maria@ligaseguradora.com.br', password: 'password', name: 'Maria')
      product_category = ProductCategory.create!(name: 'TV')

      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                                insurance_company_id: insurance_company.id,
                                price: 90.00, product_category_id: product_category.id)

      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GHI1234567')
      Policy.create(client_name: 'Maria Alves', client_registration_number: '99950033340',
                    client_email: 'mariaalves@email.com',
                    insurance_company_id: insurance_company.id, order_id: 1,
                    equipment_id: 1, purchase_date: Time.zone.today,
                    policy_period: 12, package_id: package.id, status: :pending)

      login_as(user)
      visit root_path
      click_on 'Apólices'
      click_on 'Pendentes'
      find(:css, '#pending-tab-pane').click_on 'GHI1234567'
      click_on 'Aprovar'

      expect(page).to have_content 'Apólice aprovada com sucesso'
      expect(page).to have_content 'Situação da Apólice: Pagamento Pendente'
    end

    it 'para cancelado' do
      insurance_company = InsuranceCompany.create!(name: 'Liga Seguradora', email_domain: 'ligaseguradora.com.br',
                                                   registration_number: '84157841000105')
      user = User.create!(email: 'maria@ligaseguradora.com.br', password: 'password', name: 'Maria')
      product_category = ProductCategory.create!(name: 'TV')

      package = Package.create!(name: 'Premium', min_period: 12, max_period: 24,
                                insurance_company_id: insurance_company.id,
                                price: 90.00, product_category_id: product_category.id)
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GHI1234567')
      Policy.create(client_name: 'Maria Alves', client_registration_number: '99950033340',
                    client_email: 'mariaalves@email.com',
                    insurance_company_id: insurance_company.id, order_id: 1,
                    equipment_id: 1, purchase_date: Time.zone.today,
                    policy_period: 12, package_id: package.id, status: :pending)

      login_as(user)
      visit root_path
      click_on 'Apólices'
      click_on 'Pendentes'
      find(:css, '#pending-tab-pane').click_on 'GHI1234567'
      click_on 'Reprovar'

      expect(page).to have_content 'Apólice reprovada'
      expect(page).to have_content 'Situação da Apólice: Cancelada'
    end
  end
end
