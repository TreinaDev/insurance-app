require 'rails_helper'

describe 'Usuário visita site' do
  it 'e vê conteúdo' do
    visit root_path

    expect(page).to have_css('img[src*="porcorosa"]')
    expect(page).to have_content 'Seguradoras & Pacotes'
    expect(page).to have_link 'Entrar'
  end

  it 'clica em entrar e vê imagem antes de logar' do
    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end

    expect(page).to have_css('img[src*="porcorosa"]')
  end
end
