class Propertyad < ApplicationRecord
  
    enum propertytype: { Appartement: "apartment", Maison: "house", Terrain: "ground", Parking: "parking_Box", "Non défini": "not_set" }, _suffix: true
    enum propertystate: { "Neuf (<5ans)": "recent" , Ancien: "old", Viager: "lifeannuity", "En construciton / VEFA": "offplan", "Non défini": "not_set" }, _suffix: true
    
    belongs_to :classifiedad, dependent: :destroy
    has_many :adfeatures, dependent: :destroy

    accepts_nested_attributes_for :classifiedad, allow_destroy: true 
    accepts_nested_attributes_for :adfeatures, allow_destroy: true  , reject_if: :adfeatures_invalid
    
    validates_associated :classifiedad
    validates_each :netprice ,:livingarea, :rooms, :energydiagnostic, :carbon, :availability,
    :description do |record, attr, value| record.errors.add(attr, '-- le champs ' + attr.to_s + ' est obligatoire') if value.nil? end
    validates :netprice, :rooms, :bedrooms, :buildingyear,:landarea, numericality: { only_integer: true,  allow_nil: true }

    after_initialize :set_default_property, :if => :new_record?

    def set_default_property
        self.propertytype ||= :"Non défini"
        self.propertystate ||= :"Non défini"
    end


    private

    def adfeatures_invalid(attributes)
    #   puts " propertywish_invalid #########################"
      if attributes["id"] == ""
        # puts attributes["selected"].inspect
        attributes["selected"] == "0"? true : false
      end
    end

end 