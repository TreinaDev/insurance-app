class InsuranceCompany < ApplicationRecord
  has_many :packages, dependent: nil
  has_many :pending_packages, dependent: nil

  enum company_status: { active: 0, inactive: 1 }
  validates :registration_number, length: { is: 14 }
  before_validation :generate_token, on: :create
  validates :token, length: { is: 20 }

  private

  def generate_token
    self.token = SecureRandom.alphanumeric(20).upcase
  end
end

def change
  add_index :orders, :order_number, unique: true
end
