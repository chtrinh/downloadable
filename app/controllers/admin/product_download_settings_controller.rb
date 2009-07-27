class Admin::ProductDownloadSettingsController < Admin::BaseController
  def update
    Spree::Config.set(params[:preferences])

    respond_to do |format|
      format.html {
        redirect_to admin_product_download_settings_path
      }
    end
  end
end
