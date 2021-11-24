class Propertyphoto < ActiveRecord::Base

    belongs_to :classifiedad
    belongs_to :type
    include ImageUploader::Attachment.new(:image)
  end