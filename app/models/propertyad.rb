class Propertyad < ApplicationRecord
  
    enum propertytype: { Appartement: "apartment", Maison: "house", Terrain: "ground", Parking: "parking_Box","Non défini": "not_set" }, _suffix: true
    enum propertystate: { "Neuf (<5ans)": "recent" , Ancien: "old", Viager: "lifeannuity", "En construciton / VEFA": "offplan", "Non défini": "not_set" }, _suffix: true
    
    #('','','','','loft_Workshop','castle','mansion','building','gite','chalet_mobil_home','Barge','commercial_premises','premises','commercial_property','activity_premises','various','not_set')
    belongs_to :classifiedad
    
    after_initialize :set_default_property, :if => :new_record?


    def set_default_property
        self.propertytype ||= :"Non défini"
        self.propertystate ||= :"Non défini"
    end



end 