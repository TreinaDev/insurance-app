class AddAtributesToService < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :status, :integer, default: 0
    add_column :services, :code, :string
  end
end
