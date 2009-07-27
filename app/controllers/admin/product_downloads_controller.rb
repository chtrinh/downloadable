class Admin::ProductDownloadsController < Admin::BaseController

  resource_controller
<<<<<<< HEAD:app/controllers/admin/product_downloads_controller.rb
  # note: we're using attribute_fu to manage the product_properties so the products controller will be 
  # doing most of the work
  belongs_to :product
  
=======
  belongs_to :product
>>>>>>> 5a91be7bf3d8b207465dc8688438fea192118b88:app/controllers/admin/product_downloads_controller.rb
  # after_filter :set_image, :only => [:create, :update]
   
  # 
  # new_action.response do |wants|
  #   wants.html {render :action => :new, :layout => false}
  # end
  # 
  # create.before do 
  #   option_values = params[:new_variant]
  #   option_values.each_value {|id| @object.option_values << OptionValue.find(id)}
  #   @object.save
  # end
  # 
<<<<<<< HEAD:app/controllers/admin/product_downloads_controller.rb
  # # redirect to index (instead of r_c default of show view)
  # create.response do |wants| 
  #   wants.html {redirect_to collection_url}
  # end
  # 
  
  
  create do
    flash "File successfully uploaded."
    wants.html {redirect_to collection_url}
    failure do
      flash "ERROR: Duplicate file detected."
      wants.html {redirect_to collection_url}
    end
  end
  
  create.after do 
    #object:ProductDownload
    if object.product.product_downloads.count > 1
      object.product.bundle
    end
=======
  
  # redirect to index (instead of r_c default of show view)
  create.response do |wants| 
    wants.html {redirect_to collection_url}
>>>>>>> 5a91be7bf3d8b207465dc8688438fea192118b88:app/controllers/admin/product_downloads_controller.rb
  end
  
  # redirect to index (instead of r_c default of show view)
  update.response do |wants| 
    wants.html {redirect_to collection_url}
  end
  
<<<<<<< HEAD:app/controllers/admin/product_downloads_controller.rb
  update.after do 
    #object:ProductDownload
    if object.product.product_downloads.count > 1
      object.product.bundle
    end
  end
  
  def update_product_download_limit
     product = Product.find_by_permalink(params[:id])
     if product.update_attributes(params[:product])
       flash[:notice] = "Product download limit updated."
      else
        flash[:notice] = "Product download limit failed."
      end
     redirect_to collection_url
  end
  
  def create_bundle
     product = Product.find_by_permalink(params[:product_id])
     flash[:notice] =  product.bundle ? 'Downloadable files were successfully zipped.' : 'No downloadable files to zip!'
     redirect_to collection_url
  end
  
=======
>>>>>>> 5a91be7bf3d8b207465dc8688438fea192118b88:app/controllers/admin/product_downloads_controller.rb
end