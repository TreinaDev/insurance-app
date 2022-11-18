require 'rails_helper'

describe 'Usuário vê lista de serviços' do
  it 'com sucesso' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    allow(SecureRandom).to receive(:alphanumeric).with(3).and_return('AAA')
    Service.create!(name: 'Assinatura TV',
                    description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.',
                    status: :active)
    allow(SecureRandom).to receive(:alphanumeric).with(3).and_return('AAB')
    Service.create!(name: 'Desconto clubes seguros',
                    description: 'Concede 10% de desconto em aquisição de seguro veicular.', status: :active)

    login_as(user)
    visit root_path
    click_on 'Serviços'

    expect(page).to have_content('Lista de Serviços')
    expect(page).to have_content('Serviço')
    expect(page).to have_content('Descrição')
    expect(page).to have_content('Assinatura TV')
    expect(page).to have_content('Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
    expect(page).to have_content('Desconto clubes seguros')
    expect(page).to have_content('Concede 10% de desconto em aquisição de seguro veicular')
    expect(page).to have_content('Status')
    expect(page).to have_content('Código')
    expect(page).to have_content('Ativo')
    expect(page).to have_content('AAA')
  end

  it 'com sucesso e é funcionário' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '80958759000110')
    user = User.create!(name: 'Edna', email: 'edna@empresa.com.br', password: 'password', role: :employee)
    allow(SecureRandom).to receive(:alphanumeric).with(3).and_return('AAA')
    Service.create!(name: 'Assinatura TV',
                    description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.',
                    status: :active)
    allow(SecureRandom).to receive(:alphanumeric).with(3).and_return('AAB')
    Service.create!(name: 'Desconto clubes seguros',
                    description: 'Concede 10% de desconto em aquisição de seguro veicular.', status: :active)

    login_as(user)
    visit root_path
    click_on 'Serviços'

    expect(page).to have_content('Lista de Serviços')
    expect(page).to have_content('Serviço')
    expect(page).to have_content('Descrição')
    expect(page).to have_content('Assinatura TV')
    expect(page).to have_content('Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
    expect(page).to have_content('Desconto clubes seguros')
    expect(page).to have_content('Concede 10% de desconto em aquisição de seguro veicular')
    expect(page).to have_content('Status')
    expect(page).to have_content('Código')
    expect(page).to have_content('Ativo')
    expect(page).to have_content('AAA')
  end

  it 'e não tem nenhum serviço cadastrado' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Serviços'

    expect(page).to have_content 'Não existem serviços cadastrados'
  end
end
