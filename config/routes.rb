# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :products, :has_many => [:downloadables] do |product|
    # product.create_bundle 'create_bundle/:id', :controller => 'downloadables', :action => 'create_bundle'
    # product.update_product_download_limit 'update_product_download_limit/:id', :controller => 'downloadables', 
    #                                       :action => 'update_product_download_limit'
  end
  admin.resource :downloadable_settings
end  

map.resources :downloadables