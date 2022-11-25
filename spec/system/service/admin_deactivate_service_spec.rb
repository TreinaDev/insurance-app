require 'rails_helper'

describe 'Administrador acessa Serviço específico' do
  it 'e o desativa' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    allow(SecureRandom).to receive(:alphanumeric).with(3).and_return('AAA')
    Service.create!(name: 'Assinatura TV',
                    description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.',
                    status: :active)

    login_as(user)
    visit root_path
    click_on 'Serviços'
    click_on 'AAA'
    click_on 'Desativar'

    expect(page).to have_content 'Detalhes de Serviço'
    expect(page).to have_content 'Serviço - Código: AAA'
    expect(page).to have_content 'Nome do Serviço: Assinatura TV'
    expect(page).to have_content 'Status: Inativo'
    expect(page).to have_button 'Ativar'
  end

  it 'e o ativa' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    allow(SecureRandom).to receive(:alphanumeric).with(3).and_return('AAA')
    Service.create!(name: 'Assinatura TV',
                    description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.',
                    status: :inactive)

    login_as(user)
    visit root_path
    click_on 'Serviços'
    click_on 'AAA'
    click_on 'Ativar'

    expect(page).to have_content 'Detalhes de Serviço'
    expect(page).to have_content 'Serviço - Código: AAA'
    expect(page).to have_content 'Nome do Serviço: Assinatura TV'
    expect(page).to have_content 'Status: Ativo'
    expect(page).to have_button 'Desativar'
  end
end
