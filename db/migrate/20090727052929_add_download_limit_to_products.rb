class AddDownloadLimitToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :download_limit, :integer, :default => nil
  end

  def self.down
    remove_column :products, :download_limit
  end
end