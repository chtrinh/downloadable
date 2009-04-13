# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class DownloadableExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/downloadable"

  # Please use downloadable/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    Admin::BaseController.class_eval do 
      before_filter :add_product_admin_tabs
       def add_product_admin_tabs
         @product_admin_tabs << {:name => "Downloadable Links", :url => "admin_product_product_downloads_url"}
       end
    end
    
    Product.class_eval do 
      has_many :product_downloads
      
    end
    
  end
end