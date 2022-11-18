class CoverageValidator < ActiveModel::Validator
  def validate(record)
    coverage = record.package_coverage
    return if coverage.blank?

    (record.errors.add :base, 'Invalid coverage') unless coverage.status == 'active'
  end
end
