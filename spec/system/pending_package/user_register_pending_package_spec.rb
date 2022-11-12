require 'rails_helper'

describe 'Funcionário cadastra um pacote pendente' do
  it 'e vê formulário' do
    insurance_a = InsuranceCompany.create!(name: 'Azul', email_domain: 'azul.com.br', registration_number:
                                          '01000000123410')
    user = User.create!(name: 'Funcionario', email: 'pessoa@azul.com.br', password: 'password',
                        role: :employee, insurance_company: insurance_a)

    login_as(user)
    visit root_path
    click_on 'Pacotes Pendentes'
    click_on 'Adicionar Pacote'

    expect(page).to have_content('Adicionar novo pacote')
    expect(page).to have_field('Nome')
    expect(page).to have_field('Período Mínimo')
    expect(page).to have_field('Período Máximo')
    expect(page).to have_select('Categoria')
    expect(page).to have_button('Criar Pacote')
  end

  it 'com sucesso' do
    insurance_a = InsuranceCompany.create!(name: 'Azul', email_domain: 'azul.com.br', registration_number:
                                          '01000000123410')
    user = User.create!(name: 'Funcionario', email: 'pessoa@azul.com.br', password: 'password',
                        role: :employee, insurance_company: insurance_a)
    ProductCategory.create!(name: 'Laptos')
    ProductCategory.create!(name: 'Smartphones')

    login_as(user)
    visit root_path
    click_on 'Pacotes Pendentes'
    click_on 'Adicionar Pacote'
    fill_in 'Nome', with: 'Premium'
    fill_in 'Período Mínimo', with: 12
    fill_in 'Período Máximo', with: 24
    select 'Smartphones', from: 'Categoria'
    click_on 'Criar Pacote'

    expect(page).to have_content('Pacote criado com sucesso!')
    expect(current_path).to eq(pending_packages_path)
    expect(page).to have_link('Azul')
    expect(page).to have_content('Premium')
    expect(page).to have_content('12 meses')
    expect(page).to have_content('24 meses')
    expect(page).to have_content('Smartphones')
    expect(page).to have_content('Pendente')
  end

  it 'faltando informação' do
    insurance_a = InsuranceCompany.create!(name: 'Azul', email_domain: 'azul.com.br', registration_number:
      '01000000123410')
    user = User.create!(name: 'Funcionario', email: 'pessoa@azul.com.br', password: 'password',
                        role: :employee, insurance_company: insurance_a)

    login_as(user)
    visit root_path
    click_on 'Pacotes Pendentes'
    click_on 'Adicionar Pacote'
    fill_in 'Nome', with: ''
    fill_in 'Período Mínimo', with: ''
    fill_in 'Período Máximo', with: ''
    click_on 'Criar Pacote'

    expect(page).to have_content('Pacote não foi criado')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Período Mínimo não pode ficar em branco')
    expect(page).to have_content('Período Máximo não pode ficar em branco')
  end
end
