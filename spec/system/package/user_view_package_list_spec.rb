require 'rails_helper'

describe 'Usuário vê lista de pacotes' do
  it 'com sucesso e é administrador' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password',
                        role: :admin)
    insurance = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                        '01000000123410')
    smartphones = ProductCategory.create!(name: 'Smartphones')
    pp1 = PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: insurance,
                                 product_category: smartphones)
    Package.create!(price: 3.5, pending_package_id: pp1.id, status: :active)
    pp2 = PendingPackage.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: insurance,
                                 product_category: smartphones)
    Package.create!(price: 2, pending_package_id: pp2.id, status: :active)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Pacotes'
    end

    expect(page).to have_content('Categoria')
    expect(page).to have_content('Seguradora')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Período Mínimo')
    expect(page).to have_content('Período Máximo')
    expect(page).to have_content('Preço Mensal')

    expect(page).to have_content('Smartphones')
    expect(page).to have_link('Seguradora')
    expect(page).to have_content('Premium')
    expect(page).to have_content('12 meses')
    expect(page).to have_content('24 meses')
    expect(page).to have_content('3,50%')

    expect(page).to have_content('Econômico')
    expect(page).to have_content('6 meses')
    expect(page).to have_content('18 meses')
    expect(page).to have_content('2,00%')
  end

  it 'e não tem nenhum pacote cadastrado' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password',
                        role: :admin)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Pacotes'
    end

    expect(page).to have_content('Não existem pacotes cadastrados')
  end

  it 'com sucesso e é funcionário de uma seguradora' do
    insurance_a = InsuranceCompany.create!(name: 'Azul', email_domain: 'azul.com.br', registration_number:
                                          '01000000123410')
    insurance_b = InsuranceCompany.create!(name: 'Laranja', email_domain: 'laranja.com.br', registration_number:
                                          '02000000258210')
    user = User.create!(name: 'Funcionario', email: 'pessoa@azul.com.br', password: 'password',
                        role: :employee, insurance_company: insurance_a)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    laptops = ProductCategory.create!(name: 'Laptops')
    pp1 = PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: insurance_a,
                                 product_category: smartphones)
    pp2 = PendingPackage.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: insurance_b,
                                 product_category: laptops)
    Package.create!(price: 2, pending_package_id: pp1.id, status: :active)
    Package.create!(price: 3.5, pending_package_id: pp2.id, status: :active)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Pacotes'
    end

    expect(page).to have_link('Azul')
    expect(page).to have_content('Premium')
    expect(page).to have_content('12 meses')
    expect(page).to have_content('24 meses')
    expect(page).to have_content('2,00')
    expect(page).to have_content('Smartphones')
    expect(page).not_to have_link('Laranja')
    expect(page).not_to have_content('Econômico')
    expect(page).not_to have_content('6 meses')
    expect(page).not_to have_content('18 meses')
    expect(page).not_to have_content('3,50%')
    expect(page).not_to have_content('Laptops')
  end
end
