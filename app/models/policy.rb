class Policy < ApplicationRecord
  belongs_to :insurance_company
  belongs_to :package

  validates(:code, :client_name, :client_registration_number, :client_email, :equipment_id,
            :policy_period, :order_id, presence: true)
  validates :purchase_date, :expiration_date, presence: true, if: -> { active? }
  validates :equipment_id, :order_id, :policy_period, numericality: true
  validates :order_id, :code, uniqueness: true

  enum status: { pending: 0, pending_payment: 8, active: 10, expired: 15, canceled: 20 }

  before_validation :set_expiration_date, if: -> { active? }
  before_validation :generate_code, on: :create

  has_one_attached :file

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

  def set_expiration_date
    self.purchase_date = Time.zone.today
    self.expiration_date = purchase_date + policy_period.months
  end
end
