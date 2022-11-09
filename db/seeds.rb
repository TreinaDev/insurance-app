InsuranceCompany.create!(name: 'Seguradora Vida', email_domain: 'seruradoravida.com.br',
                         registration_number: '01333288000189', company_status: 1)
InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br',
                         registration_number: '29929380000125')
InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br', registration_number: '89929380000456')
User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
User.create!(name: 'Funcionário', email: 'funcionario@portoseguro.com.br', password: 'password', role: :employee)

product_category_a = ProductCategory.create!(name: 'Celular')
product_category_b = ProductCategory.create!(name: 'TV')

product_a = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                            product_category: product_category_a)
image_path = Rails.root.join('app/assets/images/galaxy-s20-produto.jpg')
product_a.image.attach(io: image_path.open, filename: 'galaxy-s20-produto.jpg')

product_b = Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000,
                            product_category: product_category_b)
image_path = Rails.root.join('app/assets/images/tv-lg-32-produto.jpg')
product_b.image.attach(io: image_path.open, filename: 'tv-lg-32-produto.jpg')
