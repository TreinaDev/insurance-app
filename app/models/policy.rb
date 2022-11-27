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

  def approve_order(policy_id)
    policy = Policy.find_by(id: policy_id)
    json_data = { order: { status: ':insurance_approved', policy_id: policy.id.to_s, policy_code: policy.code.to_s } }
    url = "#{Rails.configuration.external_apis['comparator_api']}/orders/#{policy.order_id}/insurance_approved"
    response = Faraday.post(url, body: json_data)

    return unless response.status == 200

    policy.pending_payment!
  end

  def disapprove_order(policy_id)
    policy = Policy.find_by(id: policy_id)
    json_data = { order: { status: 'insurance_disapproved', policy_id: policy.id.to_s, policy_code: policy.code.to_s } }
    url = "#{Rails.configuration.external_apis['comparator_api']}/orders/#{policy.order_id}/insurance_disapproved"
    response = Faraday.post(url, body: json_data)

    return unless response.status == 200

    policy.canceled!
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end

  def set_expiration_date
    return unless changed.include?('status')

    self.purchase_date = Time.zone.today
    self.expiration_date = purchase_date + policy_period.months
  end
end
