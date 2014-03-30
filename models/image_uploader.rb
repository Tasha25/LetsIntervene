class ImageUploader < CarrierWave::Uploader::Base
 include CarrierWave::RMagick
include CarrierWave::MiniMagick
storage :file

def store_dir
  "letsintervene_uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
end

version :thumb do
  process :resize_to_limit => [200, 200]
end

def extension_white_list
    %w(jpg jpeg gif png)
end

  def default_url
      "/letsintervene_uploads/service_provider/image/fallback/" + ["thumb_50x50.png"].compact.join('_')
      # compact join will change this to /images/fallback/thumb_hga_logo.png
      #you have to go into the folder where all you images will be stored ["letsintervene_uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"]and create an image/fallback file in there... you should call it images/fallback but image/fallback worked for me.
      # You have to sometimes restart sinatra when you are having issues with your gems.


# code
#   def default_url
#       "/images/fallback/" + [version_name, "default.png"].compact.join('_')
#    end

# end code// sometimes you will see that a version_name will be requested and that is if you have multiple versions you will have to specify if it will be the large one or the small one.


   end

end
