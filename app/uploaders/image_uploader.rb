# gem 'image_processing'
# gem 'mini_magick'

class ImageUploader < Shrine

  
    plugin :validation_helpers
    plugin :remove_invalid
    plugin :derivatives
    plugin :store_dimensions, analyzer: :mini_magick
    plugin :upload_options, cache: { move: true }, store: { move: true }
  
    # plugin :processing
  
    Attacher.validate do
      validate_mime_type_inclusion %w[image/jpeg image/png image/gif]
      validate_max_size 5*1024*1024
      validate_extension_inclusion %w[jpg jpeg png gif]
    end

    Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)   
    { 
      small:  magick.resize_to_limit!(200, 200),
      medium: magick.resize_to_limit!(800, 800),
      large:  magick.resize_to_limit!(1024, 1024),
    }
    end
  
  end