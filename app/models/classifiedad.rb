class Classifiedad < ApplicationRecord
  
    enum adstatus: { Brouillon: "draft", "A valider": "to_validate", publiée: "published", Echec: "failed", "Non défini": "not_set" }
    
    has_one :propertyad, dependent: :destroy
    belongs_to :localisation , optional: true
    has_many :adfeatures, dependent: :destroy
    #has_many :types, through: :adfeatures 

    after_initialize :set_default_adstatus, :if => :new_record?

    def set_default_adstatus
        self.adstatus ||= :"Non défini" 
    end
end