# class InsuranceCompany
# Seguradora A
insurance_a = InsuranceCompany.create!(name: 'Liga de Seguros', email_domain: 'ligadeseguros.com.br',
                                       registration_number: '01333288000189')
logo_path = Rails.root.join('spec/support/logos/liga_seguros.PNG')
insurance_a.logo.attach(io: logo_path.open, filename: 'liga_seguros.PNG')
# Seguradora B
insurance_b = InsuranceCompany.create!(name: 'Trapiche Seguro', email_domain: 'trapicheseguro.com.br',
                                       registration_number: '29929380000125', company_status: 1)
logo_path = Rails.root.join('spec/support/logos/trapiche_seguro.PNG')
insurance_b.logo.attach(io: logo_path.open, filename: 'trapiche_seguro.PNG')
# Seguradora C
insurance_c = InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                                       registration_number: '80929380000456')
logo_path = Rails.root.join('spec/support/logos/seguradora_a.PNG')
insurance_c.logo.attach(io: logo_path.open, filename: 'seguradora_a.PNG')
# Seguradora D
insurance_d = InsuranceCompany.create!(name: 'Anjo Seguradora', email_domain: 'anjoseguradora.com.br',
                                       registration_number: '90929380000777')
logo_path = Rails.root.join('spec/support/logos/anjo_seguradora.PNG')
insurance_d.logo.attach(io: logo_path.open, filename: 'anjo_seguradora.PNG')

# class User
User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)
User.create!(name: 'Funcionário', email: 'funcionario@seguradoraa.com.br', password: 'password')

# class ProductCategory
product_category_a = ProductCategory.create!(name: 'Celular')
product_category_b = ProductCategory.create!(name: 'Televisão')
product_category_c = ProductCategory.create!(name: 'Computador')
product_category_d = ProductCategory.create!(name: 'Tablet')

# class Product
# Produto A
product_a = Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                            product_category: product_category_a)
image_path = Rails.root.join('spec/support/images/galaxy-s20-produto.jpg')
product_a.image.attach(io: image_path.open, filename: 'galaxy-s20-produto.jpg')
# Produto B
product_b = Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000,
                            product_category: product_category_b)
image_path = Rails.root.join('spec/support/images/tv32.jpeg')
product_b.image.attach(io: image_path.open, filename: 'tv32.jpeg')
# Produto C
product_c = Product.create!(product_model: 'Dell Inspirion', launch_year: '2022', brand: 'Dell', price: 3800,
                            product_category: product_category_c)
image_path = Rails.root.join('spec/support/images/dell-inspirion.jpeg')
product_c.image.attach(io: image_path.open, filename: 'dell-inspirion.jpeg')
# Produto D
product_d = Product.create!(product_model: 'iPad Pro', launch_year: '2022', brand: 'Apple', price: 7500,
                            product_category: product_category_d)
image_path = Rails.root.join('spec/support/images/ipad.jpeg')
product_d.image.attach(io: image_path.open, filename: 'ipad.jpeg')
# Produto E
product_e = Product.create!(product_model: 'iPhone 14 Pro Max', launch_year: '2022', brand: 'Apple', price: 12_000.0,
                            product_category: product_category_a)
image_path = Rails.root.join('spec/support/images/iphone.jpeg')
product_e.image.attach(io: image_path.open, filename: 'iphone.jpeg')
# Produto F
product_f = Product.create!(product_model: 'Smart Frame', launch_year: '2022', brand: 'Samsung', price: 5200,
                            product_category: product_category_b)
image_path = Rails.root.join('spec/support/images/frame.jpg')
product_f.image.attach(io: image_path.open, filename: 'frame.jpg')
# Produto G
product_g = Product.create!(product_model: 'MacBook Air', launch_year: '2022', brand: 'Apple', price: 7800,
                            product_category: product_category_c)
image_path = Rails.root.join('spec/support/images/macbook.jpeg')
product_g.image.attach(io: image_path.open, filename: 'macbook.jpeg')
# Produto H
product_h = Product.create!(product_model: 'Tab S8', launch_year: '2021', brand: 'Samsung', price: 5200,
                            product_category: product_category_d)
image_path = Rails.root.join('spec/support/images/tab.jpeg')
product_h.image.attach(io: image_path.open, filename: 'tab.jpeg')
# Produto I
product_i = Product.create!(product_model: 'iPhone 14 Pro', launch_year: '2022', brand: 'Apple', price: 10_000.0,
                            product_category: product_category_a)
image_path = Rails.root.join('spec/support/images/iphone_14.png')
product_i.image.attach(io: image_path.open, filename: 'iphone_14.png')
# Produto J
product_j = Product.create!(product_model: 'iPhone 12', launch_year: '2020', brand: 'Apple', price: 5000.0,
                            product_category: product_category_a)
image_path = Rails.root.join('spec/support/images/iphone_12.png')
product_j.image.attach(io: image_path.open, filename: 'iphone_12.png')

# class Package
# Seguradora c
package1 = Package.create!(name: 'Super Econômico', min_period: 6, max_period: 24,
                           insurance_company: insurance_c, status: :active,
                           price: 1.60, product_category: product_category_b)
package2 = Package.create!(name: 'Super Premium', min_period: 12, max_period: 24, insurance_company: insurance_c,
                           price: 1.70, product_category: product_category_a, status: :active)
Package.create!(name: 'Super Econômico', min_period: 6, max_period: 18, insurance_company: insurance_c,
                product_category: product_category_a)
# Seguradora A
package4 = Package.create!(name: 'Super Premium', min_period: 12, max_period: 24, insurance_company: insurance_a,
                           price: 0.65, product_category: product_category_b, status: :active)
package5 = Package.create!(name: 'Econômico', min_period: 6, max_period: 24,
                           insurance_company: insurance_a, status: :active,
                           price: 3.05, product_category: product_category_b)

# class Service
service1 = Service.create!(name: 'Assinatura TV',
                           description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.',
                           status: :active, code: 'ZK7')
service2 = Service.create!(name: 'Desconto clubes seguros',
                           description: 'Concede 10% de desconto em aquisição de seguro veicular.',
                           status: :active, code: 'ZK9')

# class ServicePricing
ServicePricing.create!(status: :active, percentage_price: 0.2, package: package1, service: service1)
ServicePricing.create!(status: :active, percentage_price: 0.2, package: package2, service: service2)
ServicePricing.create!(status: :active, percentage_price: 0.2, package: package5, service: service1)
ServicePricing.create!(status: :active, percentage_price: 0.2, package: package4, service: service2)

# class PackageCoverage
coverage1 = PackageCoverage.create!(name: 'Molhar',
                                    description: 'Assistência por danificação devido a molhar o aparelho.',
                                    status: :active, code: 'ZK3')
coverage2 = PackageCoverage.create!(name: 'Quebra de tela',
                                    description: 'Assistência por danificação da tela do aparelho.',
                                    status: :active, code: 'ZK4')
coverage3 = PackageCoverage.create!(name: 'Furto',
                                    description: 'Reembolso de valor em caso de roubo do aparelho.',
                                    status: :active, code: 'ZK5')

# class CoveragePricing
CoveragePricing.create!(status: :active, percentage_price: 0.2, package: package1, package_coverage: coverage1)
CoveragePricing.create!(status: :active, percentage_price: 1.2, package: package1, package_coverage: coverage2)
CoveragePricing.create!(status: :active, percentage_price: 1.5, package: package2, package_coverage: coverage2)
CoveragePricing.create!(status: :active, percentage_price: 2.5, package: package5, package_coverage: coverage3)
CoveragePricing.create!(status: :active, percentage_price: 0.45, package: package4, package_coverage: coverage3)
CoveragePricing.create!(status: :active, percentage_price: 0.35, package: package5, package_coverage: coverage2)

# class Policy

policy_a = Policy.create!(client_name: 'Maria Alves', client_registration_number: '99950033340',
                          client_email: 'mariaalves@email.com',
                          insurance_company_id: InsuranceCompany.first.id, order_id: 1,
                          equipment_id: 1,
                          policy_period: 12, package_id: Package.first.id, status: :active)
pdf_path = Rails.root.join('spec/support/policy_files/sample-policy-a.pdf')
policy_a.file.attach(io: pdf_path.open, filename: 'sample-policy-a.pdf')
Policy.create!(client_name: 'Maria Alves', client_registration_number: '99950033340',
               client_email: 'mariaalves@email.com',
               insurance_company_id: InsuranceCompany.first.id, order_id: 210,
               equipment_id: 1,
               policy_period: 12, package_id: Package.second.id, status: :canceled)
policy_b = Policy.create!(client_name: 'Rafael Souza', client_registration_number: '55511122220',
                          client_email: 'rafaelsouza@email.com',
                          insurance_company_id: InsuranceCompany.first.id, order_id: 2,
                          equipment_id: 2,
                          policy_period: 12, package_id: Package.first.id)
pdf_path = Rails.root.join('spec/support/policy_files/sample-policy-b.pdf')
policy_b.file.attach(io: pdf_path.open, filename: 'sample-policy-b.pdf')
policy_c = Policy.create!(client_name: 'Bruna Lima', client_registration_number: '66650033340',
                          client_email: 'brunalima@email.com',
                          insurance_company_id: insurance_c.id, order_id: 3,
                          equipment_id: 1,
                          policy_period: 12, package_id: Package.second.id, status: :pending)
pdf_path = Rails.root.join('spec/support/policy_files/sample-policy-c.pdf')
policy_c.file.attach(io: pdf_path.open, filename: 'sample-policy-c.pdf')
policy_d = Policy.create!(client_name: 'Rafael Souza', client_registration_number: '40511122220',
                          client_email: 'rafaelsouza@email.com',
                          insurance_company_id: insurance_c.id, order_id: 4,
                          equipment_id: 2,
                          policy_period: 12, package_id: Package.second.id, status: :active)
pdf_path = Rails.root.join('spec/support/policy_files/sample-policy-d.pdf')
policy_d.file.attach(io: pdf_path.open, filename: 'sample-policy-d.pdf')
policy_e = Policy.create!(client_name: 'Pedro Dias', client_registration_number: '66511122220',
                          client_email: 'pedrodias@email.com',
                          insurance_company_id: insurance_c.id, order_id: 5,
                          equipment_id: 2,
                          policy_period: 12, package_id: Package.second.id, status: :pending)
pdf_path = Rails.root.join('spec/support/policy_files/sample-policy-e.pdf')
policy_e.file.attach(io: pdf_path.open, filename: 'sample-policy-e.pdf')
