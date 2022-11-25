require 'rails_helper'

describe 'Usuário adiciona serviços a um pacote pendente' do
  it 'com sucesso' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    package = Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                              product_category: smartphones, status: :pending, price: 0)
    service1 = Service.create!(name: 'Assinatura TV',
                               description:
                               'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.',
                               status: :active)
    Service.create!(name: 'Desconto clubes seguros',
                    description: 'Concede 10% de desconto em aquisição de seguro veicular.', status: :active)
    service2 = Service.create!(name: 'Desconto Petlove',
                               description: 'Concede 10% de desconto em aquisição de produtos na loja Petlove.',
                               status: :active)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'
    within '#service-form' do
      select 'Assinatura TV', from: 'Serviço'
      fill_in 'Preço Percentual', with: 0.20
      click_on 'Adicionar Serviço'
      select 'Desconto Petlove', from: 'Serviço'
      fill_in 'Preço Percentual', with: 0.0
      click_on 'Adicionar Serviço'
    end

    expect(current_path).to eq package_path(package.id)
    expect(page).to have_content 'Serviço adicionado com sucesso!'
    expect(page).to have_content 'Incluir Serviço'
    within '#service-list' do
      expect(page).to have_content 'Serviço'
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Código'
      expect(page).to have_content 'Preço Percentual'
      within("#service_#{service1.id}") do
        expect(page).to have_content 'Assinatura TV'
        expect(page).to have_content 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.'
        expect(page).to have_content service1.code
        expect(page).to have_content '0,20%'
      end
      within("#service_#{service2.id}") do
        expect(page).to have_content 'Desconto Petlove'
        expect(page).to have_content 'Concede 10% de desconto em aquisição de produtos na loja Petlove.'
        expect(page).to have_content service2.code
        expect(page).to have_content '0,00%'
      end
    end
  end

  it 'incluindo serviço já adicionado' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                    product_category: smartphones, status: :pending, price: 0)
    Service.create!(name: 'Assinatura TV',
                    description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.',
                    status: :active)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'
    within '#service-form' do
      select 'Assinatura TV', from: 'Serviço'
      fill_in 'Preço Percentual', with: 0.20
      click_on 'Adicionar Serviço'
      select 'Assinatura TV', from: 'Serviço'
      fill_in 'Preço Percentual', with: 0.10
      click_on 'Adicionar Serviço'
    end

    expect(page).to have_content 'Erro na adição de Serviço'
  end

  it 'com informações incompletas' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                    product_category: smartphones, status: :pending, price: 0)
    Service.create!(name: 'Assinatura TV',
                    description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.',
                    status: :active)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'
    within '#service-form-field' do
      fill_in 'Preço Percentual', with: ''
    end
    within '#service-form-button' do
      click_on 'Adicionar Serviço'
    end

    expect(page).to have_content 'Erro na adição de Serviço'
    expect(page).to have_content 'Não existem Serviços adicionados para este Pacote'
    expect(page).to have_content 'Não existem Coberturas adicionadas para este Pacote'
  end
end

describe 'Usuário visita pagina para criar pacote' do
  it 'e não há serviços disponíveis' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                    product_category: smartphones, status: :pending, price: 0)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'

    expect(page).not_to have_content 'Adionar Serviço'
    expect(page).to have_content 'Serviço:'
    expect(page).to have_content 'Não há serviços ativos'
    expect(page).to have_content 'Preço Percentual (%):'
    expect(page).to have_content 'É preciso adicionar serviço'
  end

  it 'e só tem acesso a serviços ativos' do
    company = InsuranceCompany.create!(name: 'Seguradora Exemplo', email_domain: 'seguradora.com.br',
                                       registration_number: '80958759000110')
    user = User.create!(email: 'email@seguradora.com.br', password: 'password', name: 'Maria', role: :employee)
    smartphones = ProductCategory.create!(name: 'Smartphones')
    Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: company,
                    product_category: smartphones, status: :pending, price: 0)
    Service.create!(name: 'Desconto no Clube',
                    description: 'Concede 10% de desconto em clubes de esporte',
                    status: :active)
    Service.create!(name: 'Assinatura TV',
                    description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.',
                    status: :inactive)

    login_as(user)
    visit root_path
    click_on 'Pacotes'
    click_on 'Premium'

    within '#service-select' do
      expect(page).to have_content 'Desconto no Clube'
    end
    within '#service-select' do
      expect(page).not_to have_content 'Assinatura TV'
    end
  end
end
