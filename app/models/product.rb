class Product < ApplicationRecord
  belongs_to :product_category

  validates :product_model, :launch_year, :brand, :price,  presence: true
end
