class ProductDownload < ActiveRecord::Base
  
  belongs_to :product
  validates_presence_of :product
  validates_uniqueness_of :downloadable_file_name
  # attr_accessor :temporary_url
  
  has_attached_file :downloadable,
                    :url => "/downloadable/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/downloadable/products/:id/:style/:basename.:extension"

  before_save :set_title
                    
  def set_title
    if self.title.empty? 
      self.title = self.filename
    end
  end

  def filename
    return downloadable_file_name
  end
end
