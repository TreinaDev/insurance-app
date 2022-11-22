require 'rails_helper'

context 'POST/api/v1/orders/:id' do
  it 'altera status do Pedido com sucesso' do
    order_params = { order: { status: 3 } }

    response = Faraday.post 'https://localhost:4000/api/v1/orders/1/approved', params: order_params

    allow(Faraday).to receive(:post).with(url).and_return(response)

    expect(response).to have_http_status :created
  end
end
