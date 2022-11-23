class Product < ApplicationRecord
  belongs_to :product_category
  has_many :packages, through: :product_category

  has_one_attached :image

  validates :price, numericality: { greater_than: 0 }
  validates :product_model, :launch_year, :brand, :price, :status, presence: true
  validates :launch_year, numericality: true
  validates :launch_year, length: { is: 4 }

  enum status: { active: 0, inactive: 9 }
end
