require 'rails_helper'

describe 'Administrador cadastra categoria de produto' do
  it 'com sucesso' do
    visit new_product_category_path

    fill_in "Nome",	with: "TV"
    click_on 'Salvar'

    expect(page).to have_content 'Categoria de produto cadastrada com sucesso'
    expect(page).to have_content 'Nome: TV'
  end
  it 'com erro' do
    visit new_product_category_path
    
    fill_in "Nome",	with: ""
    click_on 'Salvar'

    expect(page).to have_content 'Ocorreu um erro'
    expect(page).to have_content 'Verifique os erros abaixo'
  end
end