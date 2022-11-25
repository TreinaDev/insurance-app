require 'rails_helper'

describe 'Administrador vê detalhes da Seguradora' do
  it 'e altera status do token para inativo' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return('ACCDEFGHIJ0123456789')
    insurance_b = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                           registration_number: '99157841000105')
    logo_path = Rails.root.join('spec/support/logos/seguradora_a.PNG')
    insurance_b.logo.attach(io: logo_path.open, filename: 'seguradora_a.PNG')

    login_as(user)
    visit root_path
    click_on 'Seguradoras'
    click_on 'Seguradora A'
    click_on 'Inativar Token'

    expect(page).to have_content("Seguradora A -\nAtivo")
    expect(page).to have_content('CNPJ:')
    expect(page).to have_content('99157841000105')
    expect(page).to have_content('Domínio de E-mail:')
    expect(page).to have_content('seguradoraa.com.br')
    expect(page).to have_content('Token de Integração:')
    expect(page).to have_content("Inativo\n- ACCDEFGHIJ0123456789")
    expect(page).to have_content('Token de Integração desativado com sucesso')
    expect(page).to have_css('img[src*="seguradora_a.PNG"]')
  end

  it 'e altera status do token para inativo' do
    user = User.create!(name: 'Aline', email: 'Aline@empresa.com.br', password: 'password', role: :admin)
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return('ACCDEFGHIJ0123456789')
    insurance_b = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                           registration_number: '99157841000105', token_status: :token_inactive)
    logo_path = Rails.root.join('spec/support/logos/seguradora_a.PNG')
    insurance_b.logo.attach(io: logo_path.open, filename: 'seguradora_a.PNG')

    login_as(user)
    visit root_path
    click_on 'Seguradoras'
    click_on 'Seguradora A'
    click_on 'Reativar Token'

    expect(page).to have_content("Seguradora A -\nAtivo")
    expect(page).to have_content('CNPJ:')
    expect(page).to have_content('99157841000105')
    expect(page).to have_content('Domínio de E-mail:')
    expect(page).to have_content('seguradoraa.com.br')
    expect(page).to have_content('Token de Integração:')
    expect(page).to have_content("Ativo\n- ACCDEFGHIJ0123456789")
    expect(page).to have_content('Token de Integração ativado com sucesso')
    expect(page).to have_css('img[src*="seguradora_a.PNG"]')
  end
end
