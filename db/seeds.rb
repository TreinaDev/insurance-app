InsuranceCompany.create!(name: 'Empresa', email_domain: 'empresa.com.br')
User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br')
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
