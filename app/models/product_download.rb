class ProductDownload < ActiveRecord::Base
<<<<<<< HEAD:app/models/product_download.rb
  
  belongs_to :product
  validates_presence_of :product
  validates_uniqueness_of :downloadable_file_name
  # attr_accessor :temporary_url
=======
  belongs_to :product
  validates_presence_of :product
  validates_presence_of :title
  # attr_accessor :temporary_url

>>>>>>> 5a91be7bf3d8b207465dc8688438fea192118b88:app/models/product_download.rb
  
  has_attached_file :downloadable,
                    :url => "/downloadable/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/downloadable/products/:id/:style/:basename.:extension"
<<<<<<< HEAD:app/models/product_download.rb
  before_save :set_title
                    
  def set_title
    if self.title.empty? 
      self.title = self.filename
    end
  end
            
=======
                    
  validates_attachment_presence :downloadable
                    
>>>>>>> 5a91be7bf3d8b207465dc8688438fea192118b88:app/models/product_download.rb
  def filename
    return downloadable_file_name
  end
end
