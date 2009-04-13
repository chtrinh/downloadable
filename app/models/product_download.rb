class ProductDownload < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :product
  validates_presence_of :title
  # attr_accessor :temporary_url

  
  has_attached_file :downloadable,
                    :url => "/downloadable/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/downloadable/products/:id/:style/:basename.:extension"
                    
  validates_attachment_presence :downloadable
                    
  def filename
    return downloadable_file_name
  end
end
