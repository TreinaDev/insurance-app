require 'rails_helper'

describe 'Administrador acessa Cobertura específica' do
  it 'e a desativa' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    allow(SecureRandom).to receive(:alphanumeric).with(3).and_return('AAA')
    PackageCoverage.create!(name: 'Molhar',
                            description: 'Assistência por danificação devido a molhar o aparelho.')

    login_as(user)
    visit root_path
    click_on 'Coberturas'
    click_on 'AAA'
    click_on 'Desativar'

    expect(page).to have_content 'Detalhes de Cobertura'
    expect(page).to have_content 'Cobertura - Código: AAA'
    expect(page).to have_content 'Nome da Cobertura: Molhar'
    expect(page).to have_content 'Descrição: Assistência por danificação devido a molhar o aparelho'
    expect(page).to have_content 'Status: Inativo'
    expect(page).to have_button 'Ativar'
  end

  it 'e a ativa' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    allow(SecureRandom).to receive(:alphanumeric).with(3).and_return('AAA')
    PackageCoverage.create!(name: 'Molhar',
                            description: 'Assistência por danificação devido a molhar o aparelho.', status: :inactive)

    login_as(user)
    visit root_path
    click_on 'Coberturas'
    click_on 'AAA'
    click_on 'Ativar'

    expect(page).to have_content 'Detalhes de Cobertura'
    expect(page).to have_content 'Cobertura - Código: AAA'
    expect(page).to have_content 'Nome da Cobertura: Molhar'
    expect(page).to have_content 'Descrição: Assistência por danificação devido a molhar o aparelho'
    expect(page).to have_content 'Status: Ativo'
    expect(page).to have_button 'Desativar'
  end
end
