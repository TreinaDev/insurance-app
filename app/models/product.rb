class Product < ApplicationRecord
  belongs_to :product_category

  validates :product_model, :launch_year, :brand, :price, presence: true

  validates :price, numericality: { greater_than: 0 }

  enum status: { active: 0, inactive: 9 }
end
