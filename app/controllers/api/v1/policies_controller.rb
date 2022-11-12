class Api::V1::PoliciesController < Api::V1::ApiController
  def create
    policy_params = params.require(:policy).permit(:client_name, :client_registration_number,
                                                   :client_email, :insurance_company_id, :order_id,
                                                   :equipment_id, :purchase_date, :policy_period, :package_id)
    policy = Policy.new(policy_params)
    if policy.save
      render status: :created, json: policy
    else
      render status: :precondition_failed, json: { errors: policy.errors.full_messages }
    end
  end
end
