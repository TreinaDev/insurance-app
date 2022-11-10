class ServicePricing < ApplicationRecord
  belongs_to :package
  belongs_to :service
end
