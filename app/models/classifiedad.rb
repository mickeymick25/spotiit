class Classifiedad < ApplicationRecord
  
    enum adstatus: { Brouillon: "draft", "A valider": "to_validate", publiée: "published", Echec: "failed", "Non défini": "not_set" }
    
    has_one :propertyad, dependent: :destroy, validate: false
    has_one :propertybuyad, dependent: :destroy, validate: false
    belongs_to :localisation , optional: true
    has_many :propertyphotos, dependent: :destroy
    has_many :rewards, dependent: :destroy, validate: false

    accepts_nested_attributes_for :propertyad, allow_destroy: true 
    accepts_nested_attributes_for :propertybuyad, allow_destroy: true 
    accepts_nested_attributes_for :localisation, allow_destroy: true 
    accepts_nested_attributes_for :propertyphotos, allow_destroy: true
    accepts_nested_attributes_for :rewards, allow_destroy: true

    # validates :title, :short_description, presence: {message: ": le champs est obligatoire."}
    validates :rewardPro, :rewardInd, :rewardProPercent, :rewardIndPercent, numericality: true, allow_nil: true
    validate :reward_validation2

    after_initialize :set_default_adstatus, :if => :new_record?

    def set_default_adstatus
        self.adstatus ||= :"Non défini" 
    end

    private

    def reward_validation2
        puts "########### reward_validation2"
        i=0
        rewards.each do |reward|
            if !reward.is_pro?
                if reward.percent.nil?
                    errors.add('Récompense',': Veillez saisir une récompense en % du prix du bien.')
                end
            end
            i = i+1
        end

        if i == 0
            errors.add('Récompense',': Veillez saisir une récompense.')
        end
    end


    def reward_validation
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