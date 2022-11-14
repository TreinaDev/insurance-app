class ServicePricing < ApplicationRecord
  belongs_to :pending_package
  belongs_to :service
  enum status: { active: 0, inactive: 9 }
  validates :status, presence: true
  validates :percentage_price, numericality: { in: 0..30 }
end
