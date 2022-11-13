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

# Seguradora C
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

# class PendingPackage
PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: InsuranceCompany.first,
                       product_category: product_category_a)
PendingPackage.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: InsuranceCompany.last,
                       product_category: product_category_a)
PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 18, insurance_company: InsuranceCompany.last,
                       product_category: product_category_b)
PendingPackage.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: InsuranceCompany.first,
                       product_category: product_category_b)

# class Package
Package.create!(name: 'Super Premium', min_period: 12, max_period: 24, insurance_company: InsuranceCompany.first,
                price: 30.00, product_category: product_category_a)
Package.create!(name: 'Super Econômico', min_period: 6, max_period: 18, insurance_company: InsuranceCompany.first,
                price: 7.00, product_category: product_category_a)
Package.create!(name: 'Super Premium', min_period: 12, max_period: 24, insurance_company: InsuranceCompany.last,
                price: 15.00, product_category: product_category_b)
package1 = Package.create!(name: 'Super Econômico', min_period: 6, max_period: 24,
                           insurance_company: InsuranceCompany.last,
                           price: 8.50, product_category: product_category_b)

# class Service
service1 = Service.create!(name: 'Assinatura TV',
                           description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
service2 = Service.create!(name: 'Desconto clubes seguros',
                           description: 'Concede 10% de desconto em aquisição de seguro veicular.')

# class ServicePricing
ServicePricing.create!(status: :active, percentage_price: 0.2, package: package1, service: service1)
ServicePricing.create!(status: :active, percentage_price: 0.2, package: package1, service: service2)

# class PackageCoverage
coverage1 = PackageCoverage.create!(name: 'Molhar',
                                    description: 'Assistência por danificação devido a molhar o aparelho.')
coverage2 = PackageCoverage.create!(name: 'Quebra de tela',
                                    description: 'Assistência por danificação da tela do aparelho.')
coverage3 = PackageCoverage.create!(name: 'Furto',
                                    description: 'Reembolso de valor em caso de roubo do aparelho.')

# class CoveragePricing
CoveragePricing.create!(status: :active, percentage_price: 0.2, package: package1, package_coverage: coverage1)
CoveragePricing.create!(status: :active, percentage_price: 1.2, package: package1, package_coverage: coverage2)
CoveragePricing.create!(status: :active, percentage_price: 5.5, package: package1, package_coverage: coverage3)
