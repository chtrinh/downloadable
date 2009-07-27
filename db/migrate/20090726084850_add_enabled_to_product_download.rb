class AddEnabledToProductDownload < ActiveRecord::Migration
  def self.up
    add_column :product_downloads, :enabled, :boolean, :default => true
  end

  def self.down
    remove_column :product_downloads, :enabled
  end
end