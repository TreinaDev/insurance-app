class ServicePricing < ApplicationRecord
  enum status: { active: 0, inactive: 9 }
  belongs_to :package
  belongs_to :service
end
