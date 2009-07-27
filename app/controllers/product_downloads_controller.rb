class ProductDownloadsController < Spree::BaseController
  before_filter :require_user, :only => :download
  
  ssl_required :download
  
  def download
    item = LineItem.find(params[:id])
    if(item.download_limit.nil? || (item.download_limit > 0))
      item.decrement!(:download_limit) if (!item.download_limit.nil?)
      
      # One file or a bulk zip, Admin NEEDS to create zip file in cp
      filepath = item.product.bundlefile ? (Product::ZIP_ROOT + item.product.bundlefile) :
                  item.product.product_downloads.first.downloadable.path
      
      # Can't use since users can alter the params to obtain files they haven't purchased. 
      # product_download = ProductDownload.find(params[:product_download])
    
      # In pratical use, enabled X-sendfile in your server flavor ie. Apache, lighty, etc.. 
      # DON'T use mongrel/webrick, since files are static. Resources will be wasted since it'll go thru the rails stack to 
      # fetch the file. Uncomment the line below.
      send_file filepath #, :x_sendfile => true
    else
      redirect_to :action => "error", :error_id => 1
    end
  end

  def error    
    @reason = (params[:error_id].nil? or (params[:error_id] == 0)) ? 
              t("unauthorized_access") : t("you_have_reached_your_download_limit")
  end
  
  private 
  
  # This may change. Might be redundant. 
  def require_user
    item = LineItem.find(params[:id])
    if current_user.nil? or (item.order.user.id != current_user.id)
      redirect_to :action => "error"
    end
  end
end
