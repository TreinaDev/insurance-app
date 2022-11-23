class ProductCategory < ApplicationRecord
  has_many :products, dependent: nil
  has_many :packages, dependent: nil

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
