InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

product_category_a = ProductCategory.create!(name: 'Celular')
product_category_b = ProductCategory.create!(name: 'TV')

Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                product_category: product_category_a)
Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000, product_category: product_category_b)

InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br')
InsuranceCompany.create!(name: 'Seguradora Vida', email_domain: 'seruradoravida.com.br', company_status: 1)