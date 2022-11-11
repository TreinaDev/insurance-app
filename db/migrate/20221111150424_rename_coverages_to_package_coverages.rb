class RenameCoveragesToPackageCoverages < ActiveRecord::Migration[7.0]
  def self.up
    rename_table :coverages, :package_coverages
  end

  def self.down
    rename_table :package_coverages, :coverages
  end
end
