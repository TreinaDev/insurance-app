require 'rails_helper'

describe 'Usuário tenta registra um pacote' do
  it 'e não está autenticado' do
    company = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                        '80958759000110')
    category = ProductCategory.create!(name: 'Smartphones')

    post(pending_packages_path, params: { pending_package: { name: 'Premium Platinumm ', min_period: 12, max_period: 12,
                                                             insurance_company: company, product_category: category } })

    expect(response).to redirect_to(user_session_path)
    expect(PendingPackage.all.length).to eq(0)
  end
end
