class Type  < ApplicationRecord
    has_many :adfeatures
    has_many :propertyadwishes
    has_many :propertytypewishes
    has_many :propertystatewishes
    has_many :propertydetailwishes
    has_many :sharedfeaturewishes
    has_many :insidefeaturewishes
    has_many :outsidefeaturewishes
    has_many :propertyphotos
    has_many :rewards
    
    has_many :propertybuyad, through: :propertyadwishes
    has_many :propertybuyad, through: :propertytypewishes
    has_many :propertybuyad, through: :propertystatewishes
    has_many :propertybuyad, through: :propertydetailwishes
    has_many :propertybuyad, through: :sharedfeaturewishes
    has_many :propertybuyad, through: :insidefeaturewishes
    has_many :propertybuyad, through: :outsidefeaturewishes
    has_many :propertybuyad, through: :propertyphotos
end

