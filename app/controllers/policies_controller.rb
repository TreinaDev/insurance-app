class PoliciesController < ApplicationController
  before_action :find_policy_by_id, only: [:index]
  def index
    @user_id = current_user.insurance_company_id

    @policies_all = Policy.all
    @policies_pending = Policy.pending
    @policies_pending_payment = Policy.pending_payment
    @policies_active = Policy.active
    @policies_expired = Policy.expired
    @policies_canceled = Policy.canceled
  end

  private

  def find_policy_by_id
    @policies_all_id = Policy.all.where(insurance_company_id: @user_id)
    @policies_pending_id = Policy.pending.where(insurance_company_id: @user_id)
    @policies_pending_payment_id = Policy.pending_payment.where(insurance_company_id: @user_id)
    @policies_active_id = Policy.active.where(insurance_company_id: @user_id)
    @policies_expired_id = Policy.expired.where(insurance_company_id: @user_id)
    @policies_canceled_id = Policy.canceled.where(insurance_company_id: @user_id)
  end
end
