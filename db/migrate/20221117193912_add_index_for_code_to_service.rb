class AddIndexForCodeToService < ActiveRecord::Migration[7.0]
  def change
    add_index :services, :code, unique: true
  end
end
