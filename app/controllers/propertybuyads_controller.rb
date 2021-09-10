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
    
    # if @propertybuyad.classifiedad.update(classifiedad2_params[:classifiedad]
      if @propertybuyad.update(all_params)
        puts "updatefullad------------------------------ca a marché"      
        redirect_to propertybuyads_path and return
    else
      render 'edit' 
    end

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
    
    @classifiedad= @propertybuyad.classifiedad
    @propertybuyad.classifiedad.localisation = Localisation.new


    init_propertywishes @propertybuyad
  end

  def create
    
    puts "Create Propertybuyad ###################################"
    
     propertybuyad = Propertybuyad.new (all_params)
    
     classifiedad = Classifiedad.new (classifiedad_params[:classifiedad] )
     classifiedad.sector = "Immobilier"  
     classifiedad.adstatus = "to_validate"
    
     propertybuyad.classifiedad = classifiedad
    
    
    if propertybuyad.save
        puts "save------------------------------ca a marché"
        redirect_to propertybuyads_path and return
    else
        puts "save------------------------------ca n'a pas marché"
        @propertybuyad = propertybuyad
        init_propertywishes @propertybuyad
        render 'new'
    end
  end
  
  private

  def init_propertywishes (propertybuyad)
    Type.all.each do |type|
      if type.catetory == "propertytypes"
        propertybuyad.propertytypewishes.new( type_id: type.id )
      elsif type.catetory == "propertystates"
        propertybuyad.propertystatewishes.new( type_id: type.id )
      elsif type.catetory == "propertydetails"
        propertybuyad.propertydetailwishes.new( type_id: type.id )
      elsif type.catetory == "sharedfeatures"
        propertybuyad.sharedfeaturewishes.new( type_id: type.id )
      elsif type.catetory == "insidefeatures"
        propertybuyad.insidefeaturewishes.new( type_id: type.id )
      elsif type.catetory == "outsidefeatures"
        propertybuyad.outsidefeaturewishes.new( type_id: type.id )
      elsif type.catetory == "propertylocations"
        propertybuyad.propertylocationwishes.new( type_id: type.id )
      end
    end
  end

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
    params.require(:propertybuyad).permit(:budget, :supply, :description,
      classifiedad_attributes: [:id ,:title,:short_description, :sector, :rewardPro, :rewardProPercent,:rewardInd, :rewardIndPercent, localisation_attributes: [:id,:number, :street, :district, :city, :dept, :region ]],
      propertytypewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy],
      propertystatewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
      propertydetailwishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
      sharedfeaturewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
      insidefeaturewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
      outsidefeaturewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ])    
  end

end
