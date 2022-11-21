class PoliciesController < ApplicationController
  before_action :find_policy_by_id, only: [:index]
  def index
    @policies_all = Policy.all
    @policies_pending = Policy.pending
    @policies_pending_payment = Policy.pending_payment
    @policies_active = Policy.active
    @policies_expired = Policy.expired
    @policies_canceled = Policy.canceled
  end

  private

  def find_policy_by_id
    @policies_all_id = current_user.insurance_company.policies
    @policies_pending_id = current_user.insurance_company.policies.pending
    @policies_pending_payment_id = current_user.insurance_company.policies.pending_payment
    @policies_active_id = current_user.insurance_company.policies.active
    @policies_expired_id = current_user.insurance_company.policies.expired
    @policies_canceled_id = current_user.insurance_company.policies.canceled
  end
end
