class ProductCategory < ApplicationRecord
  has_many :products, dependent: nil
end
