class Propertyphoto < ActiveRecord::Base

    belongs_to :classifiedad
    include ImageUploader::Attachment.new(:image)
  end