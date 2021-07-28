class Propertyadmgt  
    include ActiveModel::Model
    include Rails::Initializable
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :netprice ,:livingarea, :landarea ,:rooms ,:bedrooms ,:floor ,:buildingyear, :cmtyheating, :energydiagnostic, :carbon, :availability, :description,
        :orientation, :propertytype,:propertystate,:title,:short_description, :sector, :rewardPro, :rewardProPercent,
        :rewardInd, :rewardIndPercent,:number, :street, :district, :city, :dept, :region 


 
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
        transaction do
            propertyad = Propertyad.create!(netprice: netprice ,livingarea: livingarea, landarea: landarea ,  rooms: rooms , bedrooms: bedrooms , floor: floor , buildingyear: buildingyear, cmtyheating: cmtyheating, energydiagnostic: energydiagnostic, 
               carbon: carbon, availability: availability, description: description, orientation: orientation, propertytype: Propertyad.propertytypes[propertytype],propertystate: propertystate)
            
            classifiedad = propertyad.create_classifiedad!(title: title, short_description: short_description, sector: "Immobilier", adstatus: "to_validate", rewardPro: rewardPro, rewardProPercent: rewardProPercent, rewardInd: rewardInd, rewardIndPercent: rewardIndPercent)
            
            classifiedad.create_localisation!(number: number, street: street, district: district, city: city, dept: dept, region: region)
            
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
            propertyad.update!(netprice: netprice ,livingarea: livingarea, landarea: landarea ,  rooms: rooms , bedrooms: bedrooms , floor: floor , buildingyear: buildingyear, cmtyheating: cmtyheating, energydiagnostic: energydiagnostic, 
               carbon: carbon, availability: availability, description: description, orientation: orientation, propertytype: Propertyad.propertytypes[propertytype],propertystate: propertystate)
            
            propertyad.classifiedad.update!(title: title, short_description: short_description, sector: "Immobilier", adstatus: "to_validate", rewardPro: rewardPro, rewardProPercent: rewardProPercent, rewardInd: rewardInd, rewardIndPercent: rewardIndPercent)
            
            classifiedad = propertyad.classifiedad
            
            if classifiedad.localisation.nil?
                classifiedad.create_localisation!(number: number, street: street, district: district, city: city, dept: dept, region: region)
             else
                classifiedad.localisation.update!(number: number, street: street, district: district, city: city, dept: dept, region: region)
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

    def persisted?
        !(self.id.nil?)
    end
end
