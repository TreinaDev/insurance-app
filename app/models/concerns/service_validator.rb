class ServiceValidator < ActiveModel::Validator
  def validate(record)
    service = record.service
    return if service.blank?

    (record.errors.add :base, 'Invalid service') unless service.status == 'active'
  end
end
