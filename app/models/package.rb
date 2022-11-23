class Package < ApplicationRecord
  belongs_to :insurance_company
  belongs_to :product_category
  has_many :coverage_pricings, dependent: nil
  has_many :service_pricings, dependent: nil

  before_validation :set_initial_price, on: :create

  validates :name, :min_period, :max_period, presence: true
  validates :min_period, numericality: { greater_than: 0 }
  validates :min_period, comparison: { less_than_or_equal_to: :max_period }
  validates :price, numericality: { in: 0..60 }

  enum status: { pending: 0, active: 5, inactive: 9 }

  def set_initial_price
    self.price = 0 if price.nil?
  end

  def set_percentage_price
    total_price = 0
    coverage_pricings.each { |cp| total_price += cp.percentage_price }
    service_pricings.each { |sp| total_price += sp.percentage_price }
    self.price = total_price
  end

  def package_coverages
    coverages = []
    coverage_pricings.each do |cp|
      coverages << { code: cp.package_coverage.code, name: cp.package_coverage.name,
                     description: cp.package_coverage.description }
    end
    coverages
  end

  def package_services
    services = []
    service_pricings.each do |sp|
      services << { code: sp.service.code, name: sp.service.name,
                    description: sp.service.description }
    end
    services
  end
end
