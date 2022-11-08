InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

product_category_a = ProductCategory.create!(name: 'Televisão')
product_category_b = ProductCategory.create!(name: 'Celular')

Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000.0,
                product_category: product_category_a, status: :active)
Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                product_category: product_category_b, status: :inactive)
Product.create!(product_model: 'TV 50', launch_year: '2021', brand: 'Samsung', price: 8000,
                product_category: product_category_a, status: :inactive)
