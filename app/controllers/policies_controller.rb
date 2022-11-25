class PoliciesController < ApplicationController
  before_action :set_policy, only: %i[show update approved disapproved canceled]
  before_action :user_verification, only: %i[show update]

  def index
    if current_user.admin?
      find_policies
    else
      find_current_policies
      find_non_current_policies
    end
  end

  def show; end

  def update
    file_params = params.require(:policy).permit(:file)
    return unless @policy.update(file_params)

    redirect_to @policy, notice: t('.success')
  end

  def approved
    policy_id = @policy.id
    @policy.approve_order(policy_id)
    redirect_to @policy, notice: t('.success')
  end

  def disapproved
    policy_id = @policy.id
    @policy.disapprove_order(policy_id)
    redirect_to @policy, notice: t('.success')
  end

  def canceled
    @policy.canceled!
    redirect_to @policy, notice: t('.success')
  end

  private

  def find_current_policies
    @policies_all_id = current_user.insurance_company.policies
    @policies_pending_id = current_user.insurance_company.policies.pending
    @policies_pending_payment_id = current_user.insurance_company.policies.pending_payment
    @policies_active_id = current_user.insurance_company.policies.active.order(updated_at: :desc)
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

  def set_policy
    @policy = Policy.find(params[:id])
  end

  def user_verification
    return if current_user.insurance_company == @policy.insurance_company || current_user.admin?

    redirect_to root_url, alert: t('.forbidden')
  end
end
