InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)