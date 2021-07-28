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

        if @propertyadmgt.savefullad(params[:id])
            puts "updatefullad------------------------------ca a marché"
            redirect_to propertyadmgts_path and return
        else
            puts "updatefullad------------------------------ca n'a pas marché"
            render :create
        end
    end

    def edit 
        @propertyad = Propertyad.includes(:classifiedad).find(params[:id])        

        @propertyadmgt = Propertyadmgt.new     
        @propertyadmgt.id = @propertyad.id
        
        loadpropertyadinfo
        loadclassifiedadinfo
        loadlocationinfo
    end

    def update        
        @propertyadmgt = Propertyadmgt.new

        @propertyadmgt.assign_attributes(classifiedad_params)
        @propertyadmgt.assign_attributes(localisation_params)
        @propertyadmgt.assign_attributes(propertyadmgt_params)
        
        if @propertyadmgt.updatefullad(params[:id])
            puts "updatefullad------------------------------ca a marché"
            redirect_to propertyadmgts_path and return
        else
            puts "updatefullad------------------------------ca n'a pas marché"
            render :edit
        end

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
            propertytype: @propertyad.propertytype ,
            propertystate: @propertyad.propertystate}
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
end
    