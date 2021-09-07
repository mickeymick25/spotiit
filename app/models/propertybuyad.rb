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


    belongs_to :classifiedad


    after_initialize :set_property_wish
   
    
    def set_property_wish

        puts "set_property_wish---------------------------------------"
        # propertyadwishes.each do |wish|
        #     type = Type.find(wish.type_id)
        #     if type.catetory == "propertytypes"
        #         propertytypewishes.build( type_id: wish.type_id, id: wish.id, wishlevel: wish.wishlevel, comment: wish.comment, propertytypewish_id: id )
        #     # elsif type.catetory == "propertystates"
        #     #     propertystatewishes.build( type_id: wish.type_id, id: wish.id, wishlevel: wish.wishlevel, comment: wish.comment )
        #     # elsif type.catetory == "propertydetails"
        #     #     propertydetailwishes.build( type_id: wish.type_id, id: wish.id, wishlevel: wish.wishlevel, comment: wish.comment )
        #     # elsif type.catetory ==  "sharedfeatures"
        #     #     sharedfeaturewishes.build( type_id: wish.type_id, id: wish.id, wishlevel: wish.wishlevel, comment: wish.comment )
        #     # elsif type.catetory == "insidefeatures"
        #     #     insidefeaturewishes.build( type_id: wish.type_id, id: wish.id, wishlevel: wish.wishlevel, comment: wish.comment )
        #     # elsif type.catetory == "outsidefeatures"
        #     #     outsidefeaturewishes.build( type_id: wish.type_id, id: wish.id, wishlevel: wish.wishlevel, comment: wish.comment )
        #     # elsif type.catetory == "propertylocations"
        #     #     propertylocationwishes.build( type_id: wish.type_id, id: wish.id, wishlevel: wish.wishlevel, comment: wish.comment )
        #     end
        # end
    end

    def getpropertytypewish

        propertyadwishes.each do |wish|
            type = Type.find(wish.type_id)
            if type.catetory == "propertytypes"
                self.build( type_id: wish.type_id, id: wish.id, wishlevel: wish.wishlevel, comment: wish.comment )
            end
        end
    end

    def createfullad 

        transaction do
            ##################### createfullad
            
            classifiedad.localisation.save
          #  puts localisation.inspect
            #classifiedad.localisation_id = localisation.id

        #    self.classifiedad_id = classifiedad.id

        #    pba = Propertybuyad.create!(budget: budget, supply: supply, financing: financing, description: description, classifiedad_id: classifiedad.id)

            propertyadwishes.each do |wish|
         #       wish.propertybuyad_id = pba.id
                
                wish.save!
            end
            
            # puts self.inspect
        end
        true
        #  rescue StatementInvalid => e
        #   # Handle exception that caused the transaction to fail
        #   # e.message and e.cause.message can be helpful
        #   errors.add(:base, e.message)
        #  end
        # false
    end

    def updatefullad

        puts "####################### updatefullad"

        puts classifiedad.inspect
        
        puts propertyadwishes.inspect
        transaction do
            ##################### createfullad
            
            # classifiedad.localisation.save
            # propertyadwishes.each do |wish|
            #     wish.save!
            # end

            self.save!
        end
        true
    end

    private

    def propertywish_invalid(attributes)
      puts " propertywish_invalid #########################"
      if attributes["id"] == ""
        puts attributes["wishlevel"].inspect
        attributes["wishlevel"] == "0"? true : false
      end
    end
end