class Policy < ApplicationRecord
  belongs_to :insurance_company

  validates(:code, :expiration_date, :client_name, :client_registration_number, :client_email, :equipment_id,
            :purchase_date, :policy_period, :package_id, :order_id, presence: true)
  validates :equipment_id, :order_id, :policy_period, numericality: true
  validates :order_id, :code, uniqueness: true

  enum status: { pending: 0, pending_payment: 8, active: 10, canceled: 20 }

  before_validation :set_expiration_date, on: :create
  before_validation :generate_code, on: :create

  has_one_attached :file

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

  def set_expiration_date
    return unless purchase_date.present? && policy_period.present?

    self.expiration_date = purchase_date + policy_period.months
  end
end
