require 'rails_helper'

describe 'Usuário vê lista de Coberturas' do
  it 'com sucesso e é admin' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
    PackageCoverage.create!(name: 'Molhar',
                            description: 'Assistência por danificação devido a molhar o aparelho.')
    PackageCoverage.create!(name: 'Quebra de tela',
                            description: 'Assistência por danificação da tela do aparelho.')

    login_as(user)
    visit root_path
    click_on 'Coberturas'

    within('table') do
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Cobertura'
      expect(page).to have_content 'Molhar'
      expect(page).to have_content 'Assistência por danificação devido a molhar o aparelho'
      expect(page).to have_content 'Quebra de tela'
      expect(page).to have_content 'Assistência por danificação da tela do aparelho'
    end
  end

  it 'com sucesso e é funcionário de seguradora' do
    InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '80958759000110')
    user = User.create!(name: 'Edna', email: 'edna@empresa.com.br', password: 'password', role: :employee)
    PackageCoverage.create!(name: 'Molhar',
                            description: 'Assistência por danificação devido a molhar o aparelho.')
    PackageCoverage.create!(name: 'Quebra de tela',
                            description: 'Assistência por danificação da tela do aparelho.')

    login_as(user)
    visit root_path
    click_on 'Coberturas'

    within('table') do
      expect(page).to have_content 'Descrição'
      expect(page).to have_content 'Cobertura'
      expect(page).to have_content 'Molhar'
      expect(page).to have_content 'Assistência por danificação devido a molhar o aparelho'
      expect(page).to have_content 'Quebra de tela'
      expect(page).to have_content 'Assistência por danificação da tela do aparelho'
    end
  end

  it 'e não está logado' do
    visit root_path

    expect(page).not_to have_link 'Coberturas'
  end

  it 'com sucesso e não existem coberturas' do
    user = User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

    login_as(user)
    visit root_path
    click_on 'Coberturas'

    expect(page).to have_content 'Não existem coberturas cadastradas'
  end
end
