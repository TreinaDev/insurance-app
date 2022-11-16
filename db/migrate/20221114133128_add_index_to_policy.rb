class AddIndexToPolicy < ActiveRecord::Migration[7.0]
  def change
    add_index :policies, :order_id, unique: true
    add_index :policies, :code, unique: true
  end
end
