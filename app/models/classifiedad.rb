class Classifiedad < ApplicationRecord
  
    enum adstatus: { Brouillon: "draft", "A valider": "to_validate", publiée: "published", Echec: "failed", "Non défini": "not_set" }
    
    has_one :propertyad, dependent: :destroy, validate: false
    has_one :propertybuyad, dependent: :destroy, validate: false
    belongs_to :localisation , optional: true
    has_many :adfeatures, dependent: :destroy
    #has_many :types, through: :adfeatures 
    
    accepts_nested_attributes_for :adfeatures, allow_destroy: true 
    accepts_nested_attributes_for :localisation, allow_destroy: true 
    accepts_nested_attributes_for :propertybuyad, allow_destroy: true 
    accepts_nested_attributes_for :propertyad, allow_destroy: true 

    validates :title, :short_description, presence: {message: ": le champs est obligatoire."}
    validates :rewardPro, :rewardInd, :rewardProPercent, :rewardIndPercent, numericality: true, allow_nil: true
    validate :reward_validation

    after_initialize :set_default_adstatus, :if => :new_record?

    def set_default_adstatus
        self.adstatus ||= :"Non défini" 
    end

    private

    def reward_validation
        puts "########### reward_validation"
        puts fixedreward.inspect
        if !fixedreward.nil? && fixedreward.to_s == "true"
            if rewardPro.nil? && rewardInd.nil?
                errors.add('Récompense',': Vous devez saisir au moins un montant')
            else 
                if rewardPro.nil? && (rewardPro < 0  || 50000 < rewardPro)
                    errors.add('Récompense Pro',": Le montant de la récompense n'est pas valide")
                end
                if rewardPro.nil? && (rewardInd < 0  || 50000 < rewardInd)
                    errors.add('Récompense Particulier',": Le montant de la récompense n'est pas valide")
                end
            end
        else
            if rewardProPercent.nil? && rewardIndPercent.nil?
                errors.add('Récompense',': Vous devez saisir au moin un pourcentage')
            else 
                if rewardProPercent.nil? && (rewardProPercent < 0  || 100 < rewardProPercent)
                    errors.add('RécompensePro',": Le % de la récompense n'est pas valide")
                end
                if rewardIndPercent.nil? && ( rewardIndPercent < 0  || 100 < rewardIndPercent)
                    errors.add('RécompenseParticulier',": Le % de la récompense n'est pas valide")
                end
            end        
        end
    end
end