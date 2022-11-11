require 'rails_helper'

describe 'Usuário vê lista de pacotes pendentes' do
  it 'com sucesso e é administrador' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password',
                        role: :admin)
    c = InsuranceCompany.create!(name: 'Seguradora', email_domain: 'seguradora.com.br', registration_number:
                                      '01000000123410')
    category = ProductCategory.create!(name: 'Smartphones')
    PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: c, product_category:
                          category)
    PendingPackage.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: c, product_category:
                          category)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Pacotes Pendentes'
    end

    expect(page).to have_content('Lista de Pacotes Pendentes')
    expect(page).to have_content('Categoria')
    expect(page).to have_content('Seguradora')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Período Mínimo')
    expect(page).to have_content('Período Máximo')
    expect(page).to have_content('Status')

    expect(page).to have_content('Smartphones')
    expect(page).to have_link('Seguradora')
    expect(page).to have_content('Premium')
    expect(page).to have_content('12 meses')
    expect(page).to have_content('24 meses')
    expect(page).to have_content('Pendente')
    expect(page).to have_content('Econômico')
    expect(page).to have_content('6 meses')
    expect(page).to have_content('18 meses')
  end

  it 'e não tem nenhum pacote pendente cadastrado' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password',
                        role: :admin)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Pacotes Pendentes'
    end

    expect(page).to have_content('Não existem pacotes pendentes cadastrados')
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
    PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: insurance_a,
                          product_category: smartphones)
    PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: insurance_b,
                          product_category: laptops)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Pacotes Pendentes'
    end

    expect(page).to have_link('Azul')
    expect(page).to have_content('Premium')
    expect(page).to have_content('12 meses')
    expect(page).to have_content('24 meses')
    expect(page).to have_content('Smartphones')
    expect(page).to have_content('Pendente')
    expect(page).not_to have_link('Laranja')
    expect(page).not_to have_content('Econômico')
    expect(page).not_to have_content('6 meses')
    expect(page).not_to have_content('18 meses')
    expect(page).not_to have_content('Laptops')
  end
end
