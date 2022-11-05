class Product < ApplicationRecord
  belongs_to :product_category

  enum status: { active: 0, inactive: 9 }
end
