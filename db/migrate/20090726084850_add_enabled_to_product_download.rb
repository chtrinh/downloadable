class AddEnabledToProductDownload < ActiveRecord::Migration
  def self.up
    add_column :product_downloads, :enabled, :boolean, :default => true
    add_column :product_downloads, :viewable_id, :integer
    add_column :product_downloads, :viewable_type, :string
    add_column :product_downloads, :position, :integer
  end

  def self.down
    remove_column :product_downloads, :enabled
    remove_column :product_downloads, :viewable_id
    remove_column :product_downloads, :viewable_type
    remove_column :product_downloads, :position
  end
end