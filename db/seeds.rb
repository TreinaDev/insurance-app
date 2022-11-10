InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzseguros.com.br',
                         registration_number: '01333288000189', company_status: 1)
InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br',
                         registration_number: '29929380000125')

User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                         registration_number: '80929380000456')
User.create!(name: 'Funcionário', email: 'funcionario@seguradoraa.com.br', password: 'password')

product_category_a = ProductCategory.create!(name: 'Celular')
product_category_b = ProductCategory.create!(name: 'Televisão')

product_a = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                            product_category: product_category_a)
image_path = Rails.root.join('spec/support/images/galaxy-s20-produto.jpg')
product_a.image.attach(io: image_path.open, filename: 'galaxy-s20-produto.jpg')

product_b = Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000,
                            product_category: product_category_b)
image_path = Rails.root.join('spec/support/images/tv32.jpeg')
product_b.image.attach(io: image_path.open, filename: 'tv32.jpeg')

coverage1 = Coverage.create!(name: 'Molhar',
                                   description: 'Assistencia por danificação devido a molhar o aparelho.')