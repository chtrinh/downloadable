class CreateProductDownloads < ActiveRecord::Migration
  def self.up
    create_table :product_downloads do |t|
      t.string :title
      t.integer :product_id
      t.string :description
      t.string :downloadable_file_name
      t.string :downloadable_content_type
      t.integer :downloadable_file_size
      t.timestamps
    end
    add_index :product_downloads, :product_id
  end

  def self.down
    drop_table :product_downloads
  end
end
