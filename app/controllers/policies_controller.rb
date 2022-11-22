class PoliciesController < ApplicationController
  def index
    if current_user.admin?
      find_policies
    else
      find_current_policies
      find_non_current_policies
    end
  end

  def show
    @policy = Policy.find(params[:id])
    user_verification
  end

  def approved
    @policy = Policy.find(params[:id])
    @policy.pending_payment!
    redirect_to @policy, notice: t('.success')
    order_id = @policy.order_id
    approve_order(order_id)
  end

  def disapproved
    @policy = Policy.find(params[:id])
    @policy.canceled!
    redirect_to @policy, notice: t('.success')
  end

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

  def user_verification
    return if current_user.insurance_company == @policy.insurance_company || current_user.admin?

    redirect_to root_url, alert: t('.forbidden')
  end

  def approve_order(order_id)
    response = Faraday.post do |req|
      req.url "http://localhost:4000/orders/#{order_id}/approved"
      req.headers['Content-Type'] = 'application/json'
      req.body = "{ 'order': { 'status': '3'} }"
    end

    if response.status == 200
      message 'Aprovação efetuada com sucesso'
    else
      alert 'Não foi possível efetuar a aprovação'
    end
  end

end
