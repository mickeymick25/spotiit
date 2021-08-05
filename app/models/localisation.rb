class Localisation < ApplicationRecord
      
    has_one :classifiedad, dependent: :destroy
end