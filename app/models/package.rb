class Package < ApplicationRecord
  belongs_to :pending_package

  enum status: { active: 9, inactive: 17 }
end
