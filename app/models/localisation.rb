class Localisation < ApplicationRecord
      
    has_one :classifiedad, dependent: :destroy
    accepts_nested_attributes_for :classifiedad, allow_destroy: true 
end