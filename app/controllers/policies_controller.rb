class PoliciesController < ApplicationController
  def index
    if current_user.admin?
      find_policies
    else
      find_current_policies
      find_non_current_policies
    end
  end

  # def find_policies_by_status(current_status)
  #   if current_user.admin?
  #     policies = current_user.policies.where(status: current_status)
  #   else
  #     policies = current_user.insurance_company.policies.current_status
  #   end
  # end

  private

  def find_current_policies
    @policies_all_id = current_user.insurance_company.policies
    @policies_pending_id = current_user.insurance_company.policies.pending
    @policies_pending_payment_id = current_user.insurance_company.policies.pending_payment
    @policies_active_id = current_user.insurance_company.policies.active
  end

  def find_non_current_policies
    @policies_expired_id = current_user.insurance_company.policies.expired
    @policies_canceled_id = current_user.insurance_company.policies.canceled
  end

  def find_policies
    @policies_all = Policy.all
    @policies_pending = Policy.pending
    @policies_pending_payment = Policy.pending_payment
    @policies_active = Policy.active
    @policies_expired = Policy.expired
    @policies_canceled = Policy.canceled
  end
end
