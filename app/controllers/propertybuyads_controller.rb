class PropertybuyadsController < ApplicationController

  def index
    @propertybuyads= Propertybuyad.includes(:classifiedad).all
  end

  def show
    @propertybuyad= Propertybuyad.includes(:classifiedad).find(params[:id])
  end

  def edit 
      @propertybuyad = Propertybuyad.includes(:classifiedad, propertytypewishes: [:type]).find(params[:id])
      
      puts "########################## edit"
      
  end

  def update
    
    puts "update Propertybuyad ###################################"

    @propertybuyad= Propertybuyad.includes(:classifiedad).find(params[:id])
    
    @propertybuyad.classifiedad.update!(classifiedad2_params[:classifiedad])
   # @propertybuyad.classifiedad.localisation.update!(localisation_params[:localisation])
    
   #@propertybuyad.propertytypewishes.clear
    @propertybuyad.update!(all_params)

    puts "updatefullad------------------------------ca a marché"
    redirect_to propertybuyads_path and return

  end 

  def destroy
    @propertybuyad = Propertybuyad.find(params[:id])
    @propertybuyad.destroy 

    redirect_to propertybuyads_path
  end

  def new
    
    puts "############### new"
    @propertybuyad = Propertybuyad.new 
    
    @propertybuyad.classifiedad = Classifiedad.new
    @propertybuyad.classifiedad.localisation = Localisation.new


    Type.all.each do |type|
      if type.catetory == "propertytypes"
        @propertybuyad.propertytypewishes.build( type_id: type.id )
      elsif type.catetory == "propertystates"
        @propertybuyad.propertystatewishes.build( type_id: type.id )
      elsif type.catetory == "propertydetails"
        @propertybuyad.propertydetailwishes.build( type_id: type.id )
      elsif type.catetory == "sharedfeatures"
        @propertybuyad.sharedfeaturewishes.build( type_id: type.id )
      elsif type.catetory == "insidefeatures"
        @propertybuyad.insidefeaturewishes.build( type_id: type.id )
      elsif type.catetory == "outsidefeatures"
        @propertybuyad.outsidefeaturewishes.build( type_id: type.id )
      elsif type.catetory == "propertylocations"
        @propertybuyad.propertylocationwishes.build( type_id: type.id )
      end
    end
    
    # puts @propertybuyad.propertytypewishes.inspect

  end

  def create
    
    puts "Create Propertybuyad ###################################"
    
     propertybuyad = Propertybuyad.new (all_params)
    
     classifiedad = Classifiedad.new (classifiedad_params[:classifiedad] )
     classifiedad.sector = "Immobilier"  
     classifiedad.adstatus = "to_validate"
    
     propertybuyad.classifiedad = classifiedad
    
     #localisation = Localisation.new (localisation_params[:localisation])
    
     #propertybuyad.classifiedad.localisation = localisation
    # puts propertybuyad.propertytypewishes.inspect
    
    propertybuyad.save! # = Propertybuyad.create!(all_paramss)
    # i=0
    # loop do 

    #   wish = propertyadwishes[i]
    #   propertyadwish = Propertyadwish.new(wish)
      
    #   break if wish.nil?
        
    #   if propertyadwish.wishlevel != 0
    #   #  propertybuyad.propertytypewishes.new(wish)
    #     puts wish.inspect
    #     propertybuyad.propertyadwishes.new(wish)
        
    #   end
        
    #   i+=1
   # end 
    
    
    # if propertybuyad.createfullad 
    #     puts "createfullad------------------------------ca a marché"
         redirect_to propertybuyads_path and return
    # else
    #     puts "createfullad------------------------------ca n'a pas marché"
    #     render :edit
    # end

    #sputs propertywish_params[:propertyadwish].split(',').inspect
    # params[:propertyadwish].each do  |pw|
    #   if type.catetory == "propertytypes"
    #     propertybuyad.propertytypewishes.build( type_id: pw.type_id , catetory: Type.find(pw.type_id).category, wishleve: pw.wishleve, comment: pw.comment )
    #   end
      
    # end
    # puts propertybuyad.inspect
  end
  
  private
  def propertybuyad_params
    params.require(:propertybuyad).permit(:budget,:supply,:description)
  end
  
  def propertywish_params
    params.require(:propertybuyad).permit(propertyadwish: [ :type_id, :wishlevel, :comment ])
  end

  def classifiedad_params
    params.require(:propertybuyad).permit(classifiedad: [:title,:short_description, :sector, :rewardPro, :rewardProPercent,:rewardInd, :rewardIndPercent])
  end

  def classifiedad2_params
    params.require(:propertybuyad).permit(classifiedad: [:title,:short_description, :sector, :rewardPro, :rewardProPercent,:rewardInd, :rewardIndPercent, localisation_attributes: [:id,:number, :street, :district, :city, :dept, :region ]])
  end

  def localisation_params
      params.require(:propertybuyad).permit(localisation: [:number, :street, :district, :city, :dept, :region ])
  end

  def all_params
    params.require(:propertybuyad).permit(:budget, :supply, :description, propertytypewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy],
       propertystatewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
       propertydetailwishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
       sharedfeaturewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
       insidefeaturewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
       outsidefeaturewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ])
    
  end

end
