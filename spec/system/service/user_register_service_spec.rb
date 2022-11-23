require 'rails_helper'

describe 'Usuário administrador registra Serviço' do
  it 'a partir da tela inicial' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Serviços'
    click_on 'Adicionar Serviço'

    expect(page).to have_field('Serviço')
    expect(page).to have_field('Descrição')
    expect(page).to have_button('Criar Serviço')
  end

  it 'com sucesso' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Serviços'
    click_on 'Adicionar Serviço'
    fill_in 'Serviço', with: 'Assinatura TV'
    fill_in 'Descrição', with: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.'
    click_on 'Criar Serviço'

    expect(page).to have_content 'Serviço cadastrado com sucesso'
    within('table') do
      expect(page).to have_content 'Assinatura TV'
      expect(page).to have_content 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.'
      expect(page).to have_content 'Código'
      expect(page).to have_content 'Status'
      expect(page).to have_content 'Ativo'
    end
  end

  it 'e vê serviços já cadastrados' do
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
    click_on 'Adicionar Serviço'

    expect(page).to have_content('Cadastrar Novo Serviço')
    expect(page).to have_content('Serviço')
    expect(page).to have_content('Descrição')
    within('table') do
      expect(page).to have_content('Código')
      expect(page).to have_content('AAA')
      expect(page).to have_content('AAB')
      expect(page).to have_content('Serviço')
      expect(page).to have_content('Assinatura TV')
      expect(page).to have_content('Desconto clubes seguros')
      expect(page).to have_content('Descrição')
      expect(page).to have_content('Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
      expect(page).to have_content('Concede 10% de desconto em aquisição de seguro veicular')
      expect(page).to have_content('Status')
      expect(page).to have_content('Ativo')
    end
  end
end
