class Propertyadmgt  
    include ActiveModel::Model
    include Rails::Initializable
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :netprice, :livingarea, :landarea, :rooms, :bedrooms, :floor, :buildingyear, :cmtyheating, :energydiagnostic, :carbon, :availability, :description,
        :orientation, :propertytype, :propertystate, :title, :short_description, :sector, :rewardPro, :rewardProPercent, :rewardInd, :rewardIndPercent,
        :number, :street, :district, :city, :dept, :region,
        :has_lift, :lift_desc, :has_caretaker, :caretaker_desc, :has_balcony, :balcony_desc, :has_terrace, :terrace_desc, :has_garden, :garden_desc, :has_pool, :pool_desc,
        :has_fireplace, :fireplace_desc,:has_woodenfloor, :woodenfloor_desc, :has_separatewc, :separatewc_desc,:has_storage, :storage_desc, :has_fiber, :fiber_desc

    def id=(id)
        @id = id
    end

    def id
        @id
    end

    def initialize(params = {})
        params.each do |key, value|
            setter = "#{key}="
            send(setter, value) if respond_to?(setter.to_sym, false)
        end
        
        @id=nil
    end
    

    def savefullad
       # return false if invalid?
       ActiveRecord::Base.transaction do
            
            classifiedad = Classifiedad.create!(title: title, short_description: short_description, sector: "Immobilier", adstatus: "to_validate", rewardPro: rewardPro, rewardProPercent: rewardProPercent, rewardInd: rewardInd, rewardIndPercent: rewardIndPercent)
        
            classifiedad.create_localisation!(number: number, street: street, district: district, city: city, dept: dept, region: region)
            
            propertyad = Propertyad.create!(netprice: netprice ,livingarea: livingarea, landarea: landarea ,  rooms: rooms , bedrooms: bedrooms , floor: floor , buildingyear: buildingyear, cmtyheating: cmtyheating, energydiagnostic: energydiagnostic, 
               carbon: carbon, availability: availability, description: description, orientation: orientation, propertytype: Propertyad.propertytypes[propertytype],propertystate: propertystate,
               classifiedad_id: classifiedad.id)
            
            
            if has_lift == "1" then
                Adfeature.create!(type_id: 1, classifiedad_id: classifiedad.id, comment: lift_desc) 
            end
            if has_caretaker == "1" then
                Adfeature.create!(type_id:4, classifiedad_id: classifiedad.id, comment: caretaker_desc) 
            end
            if has_balcony == "1" then
                Adfeature.create!(type_id: 9, classifiedad_id: classifiedad.id, comment: balcony_desc) 
            end
            if has_terrace == "1" then
                Adfeature.create!(type_id: 10, classifiedad_id: classifiedad.id, comment: terrace_desc) 
            end
            if has_garden == "1" then
                Adfeature.create!(type_id: 11, classifiedad_id: classifiedad.id, comment: garden_desc) 
            end
            if has_fireplace == "1" then
                Adfeature.create!(type_id: 8, classifiedad_id: classifiedad.id, comment: pool_desc) 
            end
            if has_woodenfloor == "1" then
                Adfeature.create!(type_id: 16, classifiedad_id: classifiedad.id, comment: fireplace_desc) 
            end
            if has_separatewc == "1" then
                Adfeature.create!(type_id: 17, classifiedad_id: classifiedad.id, comment: woodenfloor_desc) 
            end
            if has_storage == "1" then
                Adfeature.create!(type_id: 18, classifiedad_id: classifiedad.id, comment: storage_desc) 
            end
            if has_pool == "1" then
                Adfeature.create!(type_id: 12, classifiedad_id: classifiedad.id, comment: fiberdesc) 
            end
            if has_fiber == "1" then
                Adfeature.create!(type_id: 15, classifiedad_id: classifiedad.id, comment: separatewc_desc) 
            end

            @id = propertyad.id
        end
        true
        #  rescue StatementInvalid => e
        #   # Handle exception that caused the transaction to fail
        #   # e.message and e.cause.message can be helpful
        #   errors.add(:base, e.message)
        #  end
        # false
    end
    
    def updatefullad (id)#(arel, name = nil, binds = [])
        
        # return false if invalid?
        ActiveRecord::Base.transaction do
            propertyad = Propertyad.find(id)
            propertyad.update!(netprice: netprice, livingarea: livingarea, landarea: landarea,  rooms: rooms, bedrooms: bedrooms, floor: floor, buildingyear: buildingyear, cmtyheating: cmtyheating, energydiagnostic: energydiagnostic, 
               carbon: carbon, availability: availability, description: description, orientation: orientation, propertytype: propertytype, propertystate: propertystate)
            
            propertyad.classifiedad.update!(title: title, short_description: short_description, sector: "Immobilier", adstatus: "to_validate", rewardPro: rewardPro, rewardProPercent: rewardProPercent, rewardInd: rewardInd, rewardIndPercent: rewardIndPercent)
            
            classifiedad = propertyad.classifiedad
            
            if classifiedad.localisation.nil?
                classifiedad.create_localisation!(number: number, street: street, district: district, city: city, dept: dept, region: region)
            else
                classifiedad.localisation.update!(number: number, street: street, district: district, city: city, dept: dept, region: region)
            end

            manageFeatures(classifiedad.adfeatures, classifiedad.id)

            @id = propertyad.id
        end
        true
         #  rescue StatementInvalid => e
         #   # Handle exception that caused the transaction to fail
         #   # e.message and e.cause.message can be helpful
         #   errors.add(:base, e.message)
         #  end
         # false
    end 

    def persisted?
        !(self.id.nil?)
    end

    private

    def createOrUpdateFeatures(adfeatures, classifiedad_id, type_id , desc)
        adfeature = adfeatures.where(type_id: type_id).first
        if adfeature.nil?
            puts "------------- ready to create"
            Adfeature.create!(type_id: type_id, classifiedad_id: classifiedad_id, comment: desc) 
        else
            puts "------------- ready to update"
            adfeature.update!(comment: desc) 
        end
    end
    
    def deteleFeatures(adfeatures, type_id)
        adfeature = adfeatures.where(type_id: type_id).first
        if !adfeature.nil?
            puts "------------- ready to destroy"
            puts adfeature.inspect
            adfeature.destroy
        end
    end

    
    def manageFeatures(adfeatures, classifiedad_id)
        if has_lift == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 1 , lift_desc)
        else
            deteleFeatures(adfeatures, 1)
        end

        if has_caretaker == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 4 , caretaker_desc)
        else
            deteleFeatures(adfeatures, 4)
        end

        if has_balcony == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 9 , balcony_desc)
        else
            deteleFeatures(adfeatures, 9)
        end

        if has_terrace == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 10 , terrace_desc)
        else
            deteleFeatures(adfeatures, 10)
        end

        if has_garden == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 11 , garden_desc)
        else
            deteleFeatures(adfeatures, 11)
        end

        if has_pool == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 12 , pool_desc)
        else
            deteleFeatures(adfeatures, 12)
        end

        if has_fireplace == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 15 , fireplace_desc)
        else
            deteleFeatures(adfeatures, 15)
        end

        if has_woodenfloor == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 16 , woodenfloor_desc)
        else
            deteleFeatures(adfeatures, 16)
        end

        if has_storage == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 18, storage_desc)
        else
            deteleFeatures(adfeatures, 18)
        end

        if has_fiber == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 8 , fiber_desc)
        else
            deteleFeatures(adfeatures, 8)
        end
        
        if has_separatewc == "1" then
            createOrUpdateFeatures(adfeatures,classifiedad_id, 17 , separatewc_desc)
        else
            deteleFeatures(adfeatures, 17)
        end

    end
    
end
