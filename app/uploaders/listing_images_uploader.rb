class ListingImagesUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  process resize_to_fit: [1280, 720]
  process convert: 'jpg'

  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

  version :thumb do
    process resize_to_fill: [200, 200]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
