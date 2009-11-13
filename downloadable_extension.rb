require_dependency 'application'

class DownloadableExtension < Spree::Extension
  version "1.0"
  description "Downloadable products"
  url "http://github.com/chtrinh/downloadable/tree/master"
  
  def self.require_gems(config)
    config.gem 'rubyzip', :lib => 'zip/zip', :version => '0.9.1'
  end
  
  def activate
    # Need a global peference for download limits
    AppConfiguration.class_eval do 
      preference :download_limit, :integer, :default => 0 # 0 for unlimited
    end
    
    # Global/General Settings for all product downloads
    Admin::ConfigurationsController.class_eval do
      before_filter :add_product_download_settings_links, :only => :index

      def add_product_download_settings_links
        @extension_links << {:link => admin_downloadable_settings_path, :link_text => t('downloadable_settings'), 
          :description => "Configure general product download settings."}
      end
    end
    
    
    Admin::BaseController.class_eval do 
      before_filter :add_product_admin_tabs
      
      # Insert downloadable link to admin product tabs
      def add_product_admin_tabs
        @product_admin_tabs << {:name => "Downloadables", :url => "admin_product_downloadables_url"}
      end
    end
    
    # ----------------------------------------------------------------------------------------------------------
    # Model class_evals 
    # ----------------------------------------------------------------------------------------------------------
    
    Product.class_eval do 
       has_many :downloadables, :as => :viewable, :order => :position, :dependent => :destroy
    end
    
    Variant.class_eval do 
       has_many :downloadables, :as => :viewable, :order => :position, :dependent => :destroy
    end
    
    
    LineItem.class_eval do 
      before_create :add_download_limit
      
      # Insert download limit to line items for orders
      def add_download_limit
        use_global = false
        
        if !self.variant.nil? and !self.variant.downloadables.empty?
          if self.variant.downloadables.first.download_limit.nil?
            use_global = true
          else
            self.download_limit = self.variant.downloadables.first.download_limit
          end
        elsif !self.product.nil? and !self.product.downloadables.empty?
          if self.product.downloadables.first.download_limit.nil?
            use_global = true
          else
            self.download_limit = self.product.downloadables.first.download_limit
          end
        end
        
        if((Spree::Config[:download_limit] != 0) && use_global)
          self.download_limit = Spree::Config[:download_limit]
        end
      end
      
    end
    
    OrderMailer.class_eval do
      # For render_links
      helper :application 
      
      # For url_for :host 
      default_url_options[:host] = Spree::Config[:site_url]
    end
    
    # ----------------------------------------------------------------------------------------------------------
    # End for Models
    # ----------------------------------------------------------------------------------------------------------
    
    # ----------------------------------------------------------------------------------------------------------
    # Helper class_evals
    # ----------------------------------------------------------------------------------------------------------
    ApplicationHelper.class_eval do
      # Checks if checkout cart has ONLY downloadable items
      # Used for shipping in helpers/checkouts_helper.rb
      def only_downloadable
        downloadable_count = 0
        @order.line_items.each do |item|
          if((!item.product.downloadables.empty?) || (!item.variant.downloadables.empty?))
            downloadable_count += 1
          end
        end
        @order.line_items.size == downloadable_count
      end
      
      def has_downloadable?
        @order.line_items.each do |item|
          return true if ((!item.product.downloadables.empty?) || (!item.variant.downloadables.empty?))
        end
      end
      
      def render_links(item)
        if !item.product.downloadables.empty?
          return content_tag(:sub,link_to("#{item.product.downloadables.first.filename}", downloadable_url(item)))
        elsif !item.variant.downloadables.empty?
          return content_tag(:sub,link_to("#{item.variant.downloadables.first.filename}", downloadable_url(item)))
        end
      end
    end
    # ----------------------------------------------------------------------------------------------------------
    # End for Helpers 
    # ----------------------------------------------------------------------------------------------------------   
  end
end