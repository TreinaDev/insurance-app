class Service < ApplicationRecord
  validates :name, :description, presence: true
  validates :name, uniqueness: true
  validates :description, length: { minimum: 3 }
end
