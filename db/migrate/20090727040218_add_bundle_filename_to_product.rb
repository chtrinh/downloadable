class AddBundleFilenameToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :bundle_filename, :string, :default => nil
  end

  def self.down
    remove_column :products, :bundle_filename
  end
end