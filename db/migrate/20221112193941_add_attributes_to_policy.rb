class AddAttributesToPolicy < ActiveRecord::Migration[7.0]
  def change
    add_column :policies, :client_name, :string
    add_column :policies, :client_registration_number, :string
    add_column :policies, :client_email, :string
    add_column :policies, :equipment_id, :integer
    add_column :policies, :purchase_date, :date
    add_column :policies, :policy_period, :integer
    add_column :policies, :package_id, :integer
    add_column :policies, :order_id, :integer
  end
end
