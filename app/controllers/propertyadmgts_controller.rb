class PropertyadmgtsController < ApplicationController
    
    def index
        @propertyads= Propertyad.includes(:classifiedad).all  
    end
    
    def show
        @propertyad = Propertyad.find(params[:id])

        # if !propertyad.classifiedad.localisation.nil?
        #     @propertyadmgt.attributes = {street: propertyad.classifiedad.localisation.street,
        #                     district: propertyad.classifiedad.localisation.district,
        #                     city: propertyad.classifiedad.localisation.city,
        #                     dept: propertyad.classifiedad.localisation.dept,
        #                     region: propertyad.classifiedad.localisation.region}
        # ends
    end

    def new
        @propertyadmgt = Propertyadmgt.new
    end

    def create
        @propertyadmgt = Propertyadmgt.new

        @propertyadmgt.assign_attributes(classifiedad_params)
        @propertyadmgt.assign_attributes(localisation_params)
        @propertyadmgt.assign_attributes(propertyadmgt_params)
        @propertyadmgt.assign_attributes(adfeature_params)

        if @propertyadmgt.savefullad
            puts "savefullad------------------------------ca a marché"
            redirect_to propertyadmgts_path and return
        else
            puts "savefullad------------------------------ca n'a pas marché"
            render :create
        end
    end

    def edit 
        @propertyad = Propertyad.includes(:classifiedad).find(params[:id])        
        
        puts "########################## edit"
        @propertyadmgt = Propertyadmgt.new     
        @propertyadmgt.id = @propertyad.id
        
        loadpropertyadinfo
        loadclassifiedadinfo
        loadlocationinfo
        loadfeaturesinfo

    end

    def update        
        @propertyadmgt = Propertyadmgt.new

        @propertyadmgt.assign_attributes(classifiedad_params)
        @propertyadmgt.assign_attributes(localisation_params)
        @propertyadmgt.assign_attributes(propertyadmgt_params)
        @propertyadmgt.assign_attributes(adfeature_params)
        
        if @propertyadmgt.updatefullad(params[:id])
            puts "updatefullad------------------------------ca a marché"
            redirect_to propertyadmgts_path and return
        else
            puts "updatefullad------------------------------ca n'a pas marché"
            render :edit
        end

    end
        
    def destroy
        @propertyad = Propertyad.find(params[:id])
        @propertyad.destroy 

        redirect_to propertyadmgts_path
    end
    

    private

    def propertyadmgt_params
        params.require(:propertyadmgt).permit(:netprice ,:livingarea,
            :landarea ,:rooms ,:bedrooms ,:floor ,:buildingyear, :cmtyheating, :energydiagnostic, :carbon, :availability, 
            :description, :orientation, :propertytype,:propertystate)
    end

    def classifiedad_params
        params.require(:propertyadmgt).permit(:title,:short_description, :sector, :rewardPro, :rewardProPercent,
            :rewardInd, :rewardIndPercent)
    end

    def localisation_params
        params.require(:propertyadmgt).permit( :number, :street, :district, :city, :dept, :region )
    end

    def adfeature_params
        params.require(:propertyadmgt).permit(:has_lift, :lift_desc, :has_caretaker, :caretaker_desc, :has_balcony, :balcony_desc, :has_terrace, :terrace_desc, :has_garden, :garden_desc, :poool_desc)
    end


    def loadpropertyadinfo 
        @propertyadmgt.attributes = {netprice: @propertyad.netprice,
            livingarea: @propertyad.livingarea,
            landarea: @propertyad.landarea,
            rooms: @propertyad.rooms,
            bedrooms: @propertyad.bedrooms,
            floor: @propertyad.floor,
            buildingyear: @propertyad.buildingyear,
            cmtyheating: @propertyad.cmtyheating,
            energydiagnostic: @propertyad.energydiagnostic,
            carbon: @propertyad.carbon,
            availability: @propertyad.availability,
            description: @propertyad.description,
            orientation: @propertyad.orientation,
            propertytype: Propertyad.propertytypes[@propertyad.propertytype],
            propertystate: Propertyad.propertystates[@propertyad.propertystate]}
    end
    
    def loadclassifiedadinfo
            @propertyadmgt.attributes = {title: @propertyad.classifiedad.title,
                short_description: @propertyad.classifiedad.short_description, 
                sector: @propertyad.classifiedad.sector,
                rewardPro: @propertyad.classifiedad.rewardPro,
                rewardProPercent: @propertyad.classifiedad.rewardProPercent, 
                rewardInd: @propertyad.classifiedad.rewardInd,
                rewardIndPercent: @propertyad.classifiedad.rewardIndPercent}
    end
    
    def loadlocationinfo
        if !@propertyad.classifiedad.localisation.nil?
            @propertyadmgt.attributes = {street: @propertyad.classifiedad.localisation.street,
                        district: @propertyad.classifiedad.localisation.district,
                        city: @propertyad.classifiedad.localisation.city,
                        dept: @propertyad.classifiedad.localisation.dept,
                        region: @propertyad.classifiedad.localisation.region}
        end 
    end
 
    def loadfeaturesinfo
        
        if @propertyad.classifiedad.adfeatures.present?
            adfeature = @propertyad.classifiedad.adfeatures.where(type_id: 1).first
            if !adfeature.nil?
                @propertyadmgt.attributes = {has_lift: 1, lift_desc: adfeature.comment}
            end
            adfeature = @propertyad.classifiedad.adfeatures.where(type_id: 2).first
            if !adfeature.nil?
                @propertyadmgt.attributes = {has_caretaker: 1, caretaker_desc: adfeature.comment}
            end
            adfeature = @propertyad.classifiedad.adfeatures.where(type_id: 3).first
            if !adfeature.nil?
                @propertyadmgt.attributes = {has_balcony: 1, balcony_desc: adfeature.comment}
            end
            adfeature = @propertyad.classifiedad.adfeatures.where(type_id: 4).first
            if !adfeature.nil?
                @propertyadmgt.attributes = {has_terrace: 1, terrace_desc: adfeature.comment}
            end
            adfeature = @propertyad.classifiedad.adfeatures.where(type_id: 5).first
            if !adfeature.nil?
                @propertyadmgt.attributes = {has_garden: 1, garden_desc: adfeature.comment}
            end
            adfeature = @propertyad.classifiedad.adfeatures.where(type_id: 6).first
            if !adfeature.nil?
                @propertyadmgt.attributes = {has_pool: 1, pool_desc: adfeature.comment}
            end
      
        end
    end

end
    