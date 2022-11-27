class Order
  attr_accessor :id, :status, :equipment, :final_price, :price, :voucher, :voucher_price, :product_model_id

  def initialize(id:, status:, equipment:, final_price:, price:,
                 voucher_price:, voucher:, product_model_id:)
    @id = id
    @status = status
    @equipment = equipment
    @final_price = final_price
    @price = price 
    @voucher = voucher 
    @voucher_price = voucher_price
    @product_model_id = product_model_id
  end

  def self.find(id)
    response = Faraday.get("#{Rails.configuration.external_apis['comparator_api']}/orders/#{id}")
    return nil unless response.success?

    d = JSON.parse(response.body)
    order = Order.new(id: d['id'], status: d['status'], equipment: d['equipment'],
                      final_price: d['final_price'], price: d['price'], voucher_price: d['voucher_price'],
                      voucher: d['voucher_code'], product_model_id: d['product_model_id'])
    order
  end
end