# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class DownloadableExtension < Spree::Extension
  version "1.0"
  description "Downloadable products"
  url "http://github.com/chtrinh/downloadable/tree/master"

  # Please use downloadable/config/routes.rb instead for extension routes.

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
        @extension_links << {:link => admin_product_download_settings_path, :link_text => t('downloadable_settings'), 
          :description => "Configure general product download settings."}
      end
    end
    
    # Insert download limit to line items for orders
    LineItem.class_eval do 
      after_save :add_download_limit
      
      def add_download_limit
        if self.download_limit.nil? and Spree::Config[:download_limit] != 0
          self.download_limit = !self.product.download_limit.nil? ? self.product.download_limit : Spree::Config[:download_limit]
          self.save
        end
      end
    end 
    
    # Insert downloadable link to admin product tabs
    Admin::BaseController.class_eval do 
      before_filter :add_product_admin_tabs
       def add_product_admin_tabs
         @product_admin_tabs << {:name => "Downloadables", :url => "admin_product_product_downloads_url"}
       end
    end
    
    ApplicationController.class_eval do 
      # Checks if checkout cart has ONLY downloadable items

      def only_downloadable
        @order.line_items.each do |item|
          return false unless item.product.downloadable
        end
      end
    end
    
    ApplicationHelper.class_eval do
      def render_links(item)
        if item.product.bundlefile
          return content_tag(:sub,link_to("#{item.product.bundle_filename}", url_for(:controller => "product_downloads",
    							:action => "download", :id => item.id, :only_path => false)))
    		else
          return content_tag(:sub,link_to("#{item.product.product_downloads.first.filename}", url_for(:controller => "product_downloads",
    							:action => "download", :id => item.id, :only_path => false)))
        end
      end
    end
    
    OrderMailer.class_eval do
      # For render_links
      helper :application 
      
      # For url_for :host 
      default_url_options[:host] = Spree::Config[:site_url]
    end
    
    Spree::Checkout.class_eval do 
      def load_checkout_steps
        @checkout_steps = %w{registration billing shipping shipping_method payment confirmation}
        @checkout_steps.delete "registration" if current_user

        @checkout_steps.delete "shipping" if only_downloadable
        @checkout_steps.delete "shipping_method" if only_downloadable
      end
    end
    
  end
end