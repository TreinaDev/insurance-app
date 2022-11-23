class Api::V1::PoliciesController < Api::V1::ApiController
  def show
    policy = Policy.find_by(code: params[:code])
    return render status: :ok, json: create_json(policy) if policy.present?

    raise ActiveRecord::RecordNotFound
  end

  def create
    policy_params = params.require(:policy).permit(:client_name, :client_registration_number,
                                                   :client_email, :insurance_company_id, :order_id,
                                                   :equipment_id, :policy_period, :package_id)
    policy = Policy.new(policy_params)
    if policy.save
      render status: :created, json: policy.as_json(except: %i[created_at updated_at])
    else
      render status: :precondition_failed, json: { errors: policy.errors.full_messages }
    end
  end

  def equipment
    policies = Policy.where(equipment_id: params[:equipment_id])
    render status: :ok, json: policies.map { |p| create_json(p) }
  end

  def order
    policy = Policy.find_by(order_id: params[:order_id])
    return render status: :ok, json: create_json(policy) if policy.present?

    raise ActiveRecord::RecordNotFound
  end

  def active
    policy = Policy.find_by(code: params[:code])
    if policy.present? && policy.pending_payment?
      policy.active!
      return render status: :ok, json: create_json(policy)
    elsif policy.present?
      return render status: :not_acceptable, json: {}
    end
    raise ActiveRecord::RecordNotFound
  end

  private

  def create_json(policy)
    p = policy.as_json(except: %i[created_at updated_at])
    p[:file_url] = url_for(policy.file) if policy.file.attached?
    p
  end
end
