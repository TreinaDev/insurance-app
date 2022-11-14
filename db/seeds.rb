# class InsuranceCompany
InsuranceCompany.create!(name: 'Allianz Seguros', email_domain: 'allianzseguros.com.br',
                         registration_number: '01333288000189', company_status: 1)
InsuranceCompany.create!(name: 'Porto Seguro', email_domain: 'portoseguro.com.br',
                         registration_number: '29929380000125')
InsuranceCompany.create!(name: 'Seguradora A', email_domain: 'seguradoraa.com.br',
                         registration_number: '80929380000456')

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

pp_a = PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 24,
                              insurance_company: InsuranceCompany.first,
                              product_category: product_category_a, status: :active)
pp_b = PendingPackage.create!(name: 'Econômico', min_period: 6, max_period: 18,
                              insurance_company: InsuranceCompany.last,
                              product_category: product_category_a, status: :active)
pp_c = PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 18,
                              insurance_company: InsuranceCompany.last,
                              product_category: product_category_b, status: :inactive)
pp_d = PendingPackage.create!(name: 'Econômico', min_period: 6, max_period: 18,
                              insurance_company: InsuranceCompany.first,
                              product_category: product_category_b, status: :active)

# class Package
Package.create!(pending_package_id: pp_a.id, price: 3, status: :active)
Package.create!(pending_package_id: pp_b.id, price: 7, status: :active)
Package.create!(pending_package_id: pp_c.id, price: 15, status: :inactive)
Package.create!(pending_package_id: pp_d.id, price: 8.5, status: :active)

# class Service
service1 = Service.create!(name: 'Assinatura TV',
                           description: 'Concede 10% de desconto em assinatura com mais canais disponíveis no mercado.')
service2 = Service.create!(name: 'Desconto clubes seguros',
                           description: 'Concede 10% de desconto em aquisição de seguro veicular.')

# class ServicePricing
ServicePricing.create!(status: :active, percentage_price: 0.2, pending_package_id: pp_a.id, service: service1)
ServicePricing.create!(status: :active, percentage_price: 0.2, pending_package_id: pp_a.id, service: service2)

# class PackageCoverage
coverage1 = PackageCoverage.create!(name: 'Molhar',
                                    description: 'Assistência por danificação devido a molhar o aparelho.')
coverage2 = PackageCoverage.create!(name: 'Quebra de tela',
                                    description: 'Assistência por danificação da tela do aparelho.')
coverage3 = PackageCoverage.create!(name: 'Furto',
                                    description: 'Reembolso de valor em caso de roubo do aparelho.')

# class CoveragePricing
CoveragePricing.create!(status: :active, percentage_price: 0.2, pending_package_id: pp_a.id,
                        package_coverage: coverage1)
CoveragePricing.create!(status: :active, percentage_price: 1.2, pending_package_id: pp_a.id,
                        package_coverage: coverage2)
CoveragePricing.create!(status: :active, percentage_price: 5.5, pending_package_id: pp_a.id,
                        package_coverage: coverage3)
