class ServiceValidator < ActiveModel::Validator
  def validate(record)
    service = record.service
    return unless service.present?

    (record.errors.add :base, 'Invalid service') unless service.status == 'active'
  end
end
