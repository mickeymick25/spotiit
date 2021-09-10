class Localisation < ApplicationRecord
      
    has_one :classifiedad, dependent: :destroy, validate: false
    accepts_nested_attributes_for :classifiedad, allow_destroy: true 
end