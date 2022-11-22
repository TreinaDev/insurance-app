require 'rails_helper'

describe 'Usúario edita uma seguradora' do
  it 'e vê as informações da seguradora' do
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    insurance = InsuranceCompany.create!(name: 'Seguradora D', email_domain: '@seguradorad.com.br',
                                         registration_number: '29929380000125')
    logo_path = Rails.root.join('spec/support/logos/seguradora_a.PNG')
    insurance.logo.attach(io: logo_path.open, filename: 'seguradora_a.PNG')

    login_as(user)
    visit root_path
    click_on 'Seguradoras'
    click_on 'Seguradora D'
    click_on 'Editar'

    expect(page).to have_css('img[src*="seguradora_a"]')
    expect(page).to have_content 'Imagem cadastrada:'
    expect(page).to have_field('Nome da Seguradora', with: 'Seguradora D')
    expect(page).to have_field('Domínio de E-mail', with: '@seguradorad.com.br')
    expect(page).to have_field('CNPJ', with: '29929380000125')
  end

  it 'com sucesso' do
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    insurance_company = InsuranceCompany.create!(name: 'Seguradora D', email_domain: 'seguradorad.com.br',
                                                 registration_number: '29929380000125')
    logo_path = Rails.root.join('spec/support/logos/porto_seguro.PNG')
    insurance_company.logo.attach(io: logo_path.open, filename: 'porto_seguro.PNG')

    login_as(user)
    visit root_path
    click_on 'Seguradoras'
    click_on 'Seguradora D'
    click_on 'Editar'
    fill_in 'CNPJ', with: '00029380000125'
    click_on 'Atualizar Seguradora'

    expect(page).to have_content('Seguradora atualizada com sucesso!')
    expect(page).to have_content('CNPJ')
    expect(page).to have_content('00029380000125')
    expect(page).to have_css('img[src*="porto_seguro.PNG"]')
  end

  it 'com informações faltando' do
    user = User.create!(email: 'email@empresa.com.br', password: 'password', name: 'Maria', role: :admin)
    insurance_company = InsuranceCompany.create!(name: 'Seguradora D', email_domain: 'seguradorad.com.br',
                                                 registration_number: '29929380000125')
    logo_path = Rails.root.join('spec/support/logos/porto_seguro.PNG')
    insurance_company.logo.attach(io: logo_path.open, filename: 'porto_seguro.PNG')

    login_as(user)
    visit root_path
    click_on 'Seguradoras'
    click_on 'Seguradora D'
    click_on 'Editar'
    fill_in 'CNPJ', with: ''
    fill_in 'Nome da Seguradora', with: ''
    click_on 'Atualizar Seguradora'

    expect(page).to have_content('Não foi possivel atualizar seguradora.')
    expect(page).to have_content('Nome da Seguradora não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
  end

  it 'e há botão voltar' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)

    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return('ACCDEFGHIJ0123456789')
    ic = InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br',
                                  registration_number: '99157841000105')

    login_as(user)
    visit root_path
    click_on 'Seguradoras'
    click_on 'Porto Seguro'
    click_on 'Editar'
    find(:css, '#back').click

    expect(current_path).to eq insurance_companies_path(ic.id)
  end
end
