class Admin::DownloadablesController < Admin::BaseController
  resource_controller
  before_filter :load_data

	new_action.response do |wants|
    wants.html {render :action => :new, :layout => false}
  end

	create.response do |wants|
		wants.html {redirect_to admin_product_downloadables_url(@product)}
  end

	update.response do |wants|
		wants.html {redirect_to admin_product_downloadables_url(@product)}
  end

	create.before do
		if params[:downloadable].has_key? :viewable_id
			if params[:downloadable][:viewable_id] == "All"
				object.viewable_type = 'Product'
				object.viewable_id = @product.id
			else
				object.viewable_type = 'Variant'
				object.viewable_id = params[:downloadable][:viewable_id]
			end
		else
			object.viewable_type = 'Product'
			object.viewable_id = @product.id
		end
	end

  destroy.before do 
    @viewable = object.viewable
  end

  destroy.response do |wants| 
    wants.html do
			render :text => ""
    end
  end

  private

  def load_data
		@product = Product.find_by_permalink(params[:product_id])
		@variants = @product.variants.collect do |variant| 
			[variant.options_text, variant.id ]
		end

		@variants.insert(0, "All")
		
		@download_limits = @product.variants.collect do |variant|
		  variant.downloadables.empty? ? ("\"#{variant.id}\": \'\'") : ("\"#{variant.id}\": #{variant.downloadables.first.download_limit}")
		end
		
  end
end
