class Propertybuyad < ApplicationRecord

    
    has_many :propertyadwishes, dependent: :destroy
    has_many :types, through: :propertyadwishes
    accepts_nested_attributes_for :propertyadwishes, allow_destroy: true , reject_if: :propertywish_invalid

    has_many :propertytypewishes, class_name: 'Propertyadwish', foreign_key: 'propertytypewish_id', dependent: :destroy
    has_many :propertystatewishes, class_name: 'Propertyadwish', foreign_key: 'propertystatewish_id', dependent: :destroy
    has_many :propertydetailwishes, class_name: 'Propertyadwish', foreign_key: 'propertydetailwish_id', dependent: :destroy
    has_many :sharedfeaturewishes, class_name: 'Propertyadwish', foreign_key: 'sharedfeaturewish_id', dependent: :destroy
    has_many :insidefeaturewishes, class_name: 'Propertyadwish', foreign_key: 'insidefeaturewish_id', dependent: :destroy
    has_many :outsidefeaturewishes, class_name: 'Propertyadwish', foreign_key: 'outsidefeaturewish_id', dependent: :destroy
    
    has_many :types, through: :propertytypewishes
    has_many :types, through: :propertystatewishes
    has_many :types, through: :propertydetailwishes
    has_many :types, through: :sharedfeaturewishes
    has_many :types, through: :insidefeaturewishes
    has_many :types, through: :outsidefeaturewishes

    accepts_nested_attributes_for :propertytypewishes, allow_destroy: true , reject_if: :propertywish_invalid
    accepts_nested_attributes_for :propertystatewishes, allow_destroy: true , reject_if: :propertywish_invalid
    accepts_nested_attributes_for :propertydetailwishes, allow_destroy: true , reject_if: :propertywish_invalid
    accepts_nested_attributes_for :sharedfeaturewishes, allow_destroy: true , reject_if: :propertywish_invalid
    accepts_nested_attributes_for :insidefeaturewishes, allow_destroy: true , reject_if: :propertywish_invalid
    accepts_nested_attributes_for :outsidefeaturewishes, allow_destroy: true , reject_if: :propertywish_invalid

    has_many :propertylocationwishes, class_name: 'Propertyadwish', foreign_key: 'propertylocationwish_id', dependent: :destroy

    belongs_to :classifiedad, validate: false, dependent: :destroy
    accepts_nested_attributes_for :classifiedad, allow_destroy: true 

    validates_each :budget, :supply, :description do |record, attr, value| record.errors.add(attr, '-- le champs ' + attr.to_s + ' est obligatoire') if value.nil? end
    validates :budget, :supply, numericality: { only_integer: true }
    validates :budget, :supply, inclusion: { in: 0..50000000, message: " doit etre supérieur à 0" }
    validates_associated :classifiedad

    # after_initialize :set_property_wish
       
    # def set_property_wish

    #     puts "set_property_wish---------------------------------------"
  
    # end


    private

    def propertywish_invalid(attributes)
    #   puts " propertywish_invalid #########################"
      if attributes["id"] == ""
        # puts attributes["wishlevel"].inspect
        attributes["wishlevel"] == "0"? true : false
      end
    end
end