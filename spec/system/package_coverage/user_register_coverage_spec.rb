require 'rails_helper'

describe 'Usuário administrador registra cobertura' do
  it 'a partir da tela inicial' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    
    login_as(user)
    visit root_path
    click_on 'Coberturas'
    click_on 'Adicionar Cobertura'

    expect(page).to have_field('Cobertura')
    expect(page).to have_field('Descrição')
    expect(page).to have_button('Criar Cobertura')
  end

  it 'com sucesso' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    
    login_as(user)
    visit root_path
    click_on 'Coberturas'
    click_on 'Adicionar Cobertura'
    fill_in 'Cobertura', with: 'Molhar'
    fill_in 'Descrição', with: 'Assistência por danificação devido a molhar o aparelho'
    click_on 'Criar Cobertura'

    expect(page).to have_content 'Cobertura cadastrada com sucesso'
    within('table') do
      expect(page).to have_content 'Molhar'
      expect(page).to have_content 'Assistência por danificação devido a molhar o aparelho'
    end
  end


  
end