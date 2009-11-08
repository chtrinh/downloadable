require 'zip/zip'
class Downloadable < ProductDownload
  has_attached_file :attachment,
                    :url => "/downloadable/:id/:basename.:extension",
                    :path => ":rails_root/public/downloadable/:id/:basename.:extension"

  
  before_save :set_title
  after_save :create_zip, :unless => :zipfile?
                    
  def filename
     return attachment_file_name
  end
  
  def zipfile?
    attachment_content_type == 'application/zip'
  end
  
  # if there are errors from the plugin, then add a more meaningful message
  def validate
    unless attachment.errors.empty?
      # uncomment this to get rid of the less-than-useful interrim messages
      # errors.clear 
      errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end
  
  private
  
  def set_title
    if(self.title.nil? || self.title.empty?)
      self.title = self.filename
    end
  end
  
  # create a zipped archive file for any product or variant with more than 1 file. 
  def create_zip
    variant_downloadable = Downloadable.find(:all, :conditions => 
                                            ["viewable_id = ? and attachment_content_type != ?", viewable_id, "application/zip"])
    
    if(variant_downloadable.size > 1)
      bundle_filename = "#{variant_downloadable.first.viewable_id}_bundle.zip"
      bundle_fullpath = "#{RAILS_ROOT}/tmp/" + bundle_filename
      
       # Create the zip file
       Zip::ZipFile.open(bundle_fullpath, Zip::ZipFile::CREATE) {
        |zipfile|
        # collect the downlodables
        variant_downloadable.each do |downloadable|
            if downloadable.enabled && (downloadable.filename != nil)
              # add each download to the archive
              zipfile.add(downloadable.filename, downloadable.attachment.path)
            end
        end 
       }
       
       # check if there is an existing zip file Downloadable object. 
       unless(zip_downloadable = Downloadable.find(:first, :conditions => ["attachment_file_name = ?", bundle_filename]))
         zip_downloadable = Downloadable.new
       end
       zip_downloadable.viewable_id = viewable_id
       zip_downloadable.viewable_type = viewable_type
       zip_downloadable.download_limit = download_limit
       zip_downloadable.description = "Zip file"
       zip_downloadable.attachment = File.new(bundle_fullpath)
       zip_downloadable.attachment_content_type = "application/zip"
       zip_downloadable.save
       zip_downloadable.move_to_top
       
       # skip callback, but update all download limits. 
       Downloadable.update_all( "download_limit = #{download_limit}", ["viewable_id = ?", viewable_id]) if !download_limit.nil?
       
       # delete file from tmp folder.
       File.delete(bundle_fullpath)
    end
  end
end