# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(name: 'Pessoa', email: 'pessoa@empresa.com.br', password: 'password', role: :admin)

product_category_a = ProductCategory.create!(name: 'Celular')
product_category_b = ProductCategory.create!(name: 'TV')

Product.create!(product_model: 'Samsung Galaxy S20', launch_year: '2018', brand: 'Samsung', price: 2000.0,
                product_category: product_category_a)
Product.create!(product_model: 'TV 32', launch_year: '2022', brand: 'LG', price: 5000,
                product_category: product_category_b)
