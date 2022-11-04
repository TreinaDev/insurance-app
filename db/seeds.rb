# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

category = ProductCategory.create!(name: "Celular")

    Product.create!(product_model: "Samsung Galaxy S20", launch_year: "2018", brand: "Samsung", price: '2000.0', product_category: category)
