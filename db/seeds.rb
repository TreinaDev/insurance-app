InsuranceCompany.create!(name: 'Seguradora Vida', email_domain: 'seruradoravida.com.br', cnpj: '01333288000189',
                         company_status: 1)
InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br', cnpj: '29929380000125')
InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', cnpj: '89929380000456')
User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
User.create!(name: 'Funcionário', email: 'funcionario@portoseguro.com.br', password: 'password', role: :employee)

product_category_a = ProductCategory.create!(name: 'Celular')
product_category_b = ProductCategory.create!(name: 'TV')

Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                product_category: product_category_a)
Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000,
                product_category: product_category_b)
