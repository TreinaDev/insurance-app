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

PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: InsuranceCompany.first,
                       product_category: product_category_a)
PendingPackage.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: InsuranceCompany.last,
                       product_category: product_category_a)
PendingPackage.create!(name: 'Premium', min_period: 12, max_period: 18, insurance_company: InsuranceCompany.last,
                       product_category: product_category_b)
PendingPackage.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: InsuranceCompany.first,
                       product_category: product_category_b)

# class Package
Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: InsuranceCompany.first,
                price: 30.00, product_category: product_category_a)
Package.create!(name: 'Econômico', min_period: 6, max_period: 18, insurance_company: InsuranceCompany.first,
                price: 7.00, product_category: product_category_a)
Package.create!(name: 'Premium', min_period: 12, max_period: 24, insurance_company: InsuranceCompany.last,
                price: 15.00, product_category: product_category_b)
package1 = Package.create!(name: 'Ecônomico', min_period: 6, max_period: 24, insurance_company: InsuranceCompany.last,
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

# class Policy

Policy.create!(client_name: 'Maria Alves', client_registration_number: '99950033340',
               client_email: 'mariaalves@email.com',
               insurance_company_id: InsuranceCompany.first.id, order_id: 1,
               equipment_id: 1, purchase_date: Time.zone.today,
               policy_period: 12, package_id: Package.first.id)
Policy.create!(client_name: 'Rafael Souza', client_registration_number: '55511122220',
               client_email: 'rafaelsouza@email.com',
               insurance_company_id: InsuranceCompany.first.id, order_id: 2,
               equipment_id: 2, purchase_date: Time.zone.today,
               policy_period: 12, package_id: Package.first.id)
