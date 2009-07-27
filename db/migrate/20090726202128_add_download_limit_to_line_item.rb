class AddDownloadLimitToLineItem < ActiveRecord::Migration
  def self.up
    add_column :line_items, :download_limit, :integer, :default => nil
  end

  def self.down
    remove_column :line_items, :download_limit
  end
end