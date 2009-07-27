# Put your extension routes here.


#map.

map.namespace :admin do |admin|
  admin.resources :products, :has_many => [:product_downloads] do |product|
    product.create_bundle 'create_bundle/:id', :controller => 'product_downloads', :action => 'create_bundle'
    product.update_product_download_limit 'update_product_download_limit/:id', :controller => 'product_downloads', 
                                          :action => 'update_product_download_limit'
  end
  admin.resource :product_download_settings
end  