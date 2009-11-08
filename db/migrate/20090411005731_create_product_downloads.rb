class CreateProductDownloads < ActiveRecord::Migration
  def self.up
    create_table :product_downloads do |t|
      t.string :title
      t.integer :download_limit
      t.string :description
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.timestamps
    end
  end

  def self.down
    drop_table :product_downloads
  end
end
