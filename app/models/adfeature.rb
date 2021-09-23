class Adfeature < ApplicationRecord

    attr_accessor :selected

    belongs_to :propertyad
    belongs_to :type

    
end
