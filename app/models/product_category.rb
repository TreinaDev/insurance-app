class ProductCategory < ApplicationRecord
  has_many :products, dependent: nil

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
