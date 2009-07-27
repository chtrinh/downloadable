# Put your extension routes here.

<<<<<<< HEAD:config/routes.rb

#map.

map.namespace :admin do |admin|
  admin.resources :products, :has_many => [:product_downloads] do |product|
    product.create_bundle 'create_bundle/:id', :controller => 'product_downloads', :action => 'create_bundle'
    product.update_product_download_limit 'update_product_download_limit/:id', :controller => 'product_downloads', 
                                          :action => 'update_product_download_limit'
  end
  admin.resource :product_download_settings
=======
map.namespace :admin do |admin|
  admin.resources :products, :has_many => :product_downloads
>>>>>>> 5a91be7bf3d8b207465dc8688438fea192118b88:config/routes.rb
end  