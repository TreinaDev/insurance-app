require 'rails_helper'

describe 'Usuário vê lista de serviços' do 
  it 'com sucesso' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    Service.create!(name: 'Assinatura TV',
                    description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
    Service.create!(name: 'Desconto clubes seguros',
                    description: 'Concede 10% de desconto em aquisição de seguro veicular.')

    login_as(user)
    visit root_path
    click_on 'Serviços'

    expect(page).to have_content('Lista de Serviços')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Descrição')
    expect(page).to have_content('Assinatura TV')
    expect(page).to have_content('Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
    expect(page).to have_content('Desconto clubes seguros')
    expect(page).to have_content('Concede 10% de desconto em aquisição de seguro veicular')
  end 

  it 'com sucesso e é funcionário' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '80958759000110')
    user = User.create!(name: 'Edna', email: 'edna@empresa.com.br', password: 'password', role: :employee)
    Service.create!(name: 'Assinatura TV',
                    description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
    Service.create!(name: 'Desconto clubes seguros',
                    description: 'Concede 10% de desconto em aquisição de seguro veicular.')

    login_as(user)
    visit root_path
    click_on 'Serviços'

    expect(page).to have_content('Lista de Serviços')
    expect(page).to have_content('Nome')
    expect(page).to have_content('Descrição')
    expect(page).to have_content('Assinatura TV')
    expect(page).to have_content('Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
    expect(page).to have_content('Desconto clubes seguros')
    expect(page).to have_content('Concede 10% de desconto em aquisição de seguro veicular')
  end 

  it 'e não tem nenhum serviço cadastrado' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Serviços'

    expect(page).to have_content 'Não existem serviços cadastrados'
  end
end
