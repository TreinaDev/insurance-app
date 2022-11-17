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

  # it 'com sucesso' do
  #   user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

  #   login_as(user)
  #   visit root_path
  #   click_on 'Serviços'
  #   click_on 'Adicionar Serviço'
  #   fill_in 'Serviço', with: 'Molhar'
  #   fill_in 'Descrição', with: 'Assistência por danificação devido a molhar o aparelho'
  #   click_on 'Criar Serviço'

  #   expect(page).to have_content 'Serviço cadastrado com sucesso'
  #   within('table') do
  #     expect(page).to have_content 'Molhar'
  #     expect(page).to have_content 'Assistência por danificação devido a molhar o aparelho'
  #   end
  # end

  # it 'e falta informações' do
  #   user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

  #   login_as(user)
  #   visit root_path
  #   click_on 'Serviços'
  #   click_on 'Adicionar Serviço'
  #   fill_in 'Serviço', with: ''
  #   fill_in 'Descrição', with: ''
  #   click_on 'Criar Serviço'

  #   expect(page).to have_content('Não foi possível cadastrar a Serviço')
  #   expect(page).to have_content('Serviço não pode ficar em branco')
  #   expect(page).to have_content('Descrição não pode ficar em branco')
  # end

  # it 'e é funcionário de seguradora' do
  #   InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '80958759000110')
  #   user = User.create!(name: 'Edna', email: 'edna@empresa.com.br', password: 'password', role: :employee)

  #   login_as(user)
  #   visit root_path
  #   click_on 'Serviços'

  #   expect(page).not_to have_link('Adicionar Serviço')
  # end
end
