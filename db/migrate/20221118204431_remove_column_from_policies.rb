class RemoveColumnFromPolicies < ActiveRecord::Migration[7.0]
  def change
    remove_column :policies, :package_id, :integer
  end
end
