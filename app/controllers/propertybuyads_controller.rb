class PropertybuyadsController < ApplicationController

  def index
    @propertybuyads= Propertybuyad.includes(classifiedad: [:localisation], propertytypewishes: [:type], propertystatewishes: [:type], 
      propertydetailwishes: [:type], insidefeaturewishes: [:typer], outsidefeaturewishes:[:type], sharedfeaturewishes: [:type] ).all
  end

  def show
    @propertybuyad= Propertybuyad.includes(:classifiedad, propertytypewishes: [:type]).find(params[:id])
  end

  def edit 
    @propertybuyad = Propertybuyad.includes(:classifiedad, propertytypewishes: [:type]).find(params[:id])
      
    puts "########################## edit"
      
  end

  def update
    
    puts "update Propertybuyad ###################################"

    @propertybuyad= Propertybuyad.includes(:classifiedad).find(params[:id])

    @propertybuyad.classifiedad.assign_attributes(classifiedad_params[:classifiedad_attributes] )
    
    @propertybuyad.classifiedad.valid?    

    if @propertybuyad.classifiedad.errors.count > 0
      render 'edit' and return
    end
    # raise ActiveRecord::RecordInvalid.new(classifiedad)

    self.calcul_reward 
    self.set_title
    
    if @propertybuyad.update(all_params)
        puts "update------------------------------ca a marché"    
      
        redirect_to propertybuyads_path and return
    else
      render 'edit' 
    end
    # rescue StandardError => e
    #   # Handle exception that caused the transaction to fail
    #   # e.message and e.cause.message can be helpful
    #   errors.add(:base, e.message)
    #   raise ActiveRecord::RecordInvalid.new(self)

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
    
    # @classifiedad= @propertybuyad.classifiedad
    @propertybuyad.classifiedad.localisation = Localisation.new
    @propertybuyad.classifiedad.propertyphotos.new()


    init_propertywishes @propertybuyad
  end

  def create
    
    puts "Create Propertybuyad ###################################"
    
    propertybuyad = Propertybuyad.new (all_params)
    
    propertybuyad.classifiedad.sector = "Immobilier"
    propertybuyad.classifiedad.adstatus = "to_validate"
    
    propertybuyad.classifiedad.valid?

    if propertybuyad.classifiedad.errors.count > 0
      render 'edit' and return
    end
    
    self.calcul_reward 
    
    puts propertybuyad.classifiedad.propertyphotos.inspect
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
        propertybuyad.propertytypewishes.new().type = type
      elsif type.catetory == "propertystates"
        propertybuyad.propertystatewishes.new().type = type 
      elsif type.catetory == "propertydetails"
        propertybuyad.propertydetailwishes.new().type = type 
      elsif type.catetory == "sharedfeatures"
        propertybuyad.sharedfeaturewishes.new().type = type 
      elsif type.catetory == "insidefeatures"
        propertybuyad.insidefeaturewishes.new().type = type 
      elsif type.catetory == "outsidefeatures"
        propertybuyad.outsidefeaturewishes.new().type = type 
      elsif type.catetory == "propertylocations"
        propertybuyad.propertylocationwishes.new().type = type
      end
    end
  end
  
  def set_title ()
    
    propertydetails = params[:propertybuyad][:propertydetailwishes_attributes].values
    puts "############ set_title"
    puts propertydetails.inspect

    types = Type.select(:typekey, :id).where(catetory: 'propertydetails').to_a

    # rooms = propertydetails.select{|i,v| v[:type_id] == types.find{ |i| i.typekey == 'rooms'}.id}
    rooms = propertydetails.select{|v| v[:type_id] == types.find{ |i| i.typekey == 'rooms'}.id.to_s}[0][:comment].to_i
    bedrooms = propertydetails.select{|v| v[:type_id] == types.find{ |i| i.typekey == 'bedrooms'}.id.to_s}[0][:comment].to_i
    livingarea = propertydetails.select{|v| v[:type_id] == types.find{ |i| i.typekey == 'livingarea'}.id.to_s}[0][:comment].to_i
    # landarea = propertydetails.select{|v| v[:type_id] == types.find{ |i| i.typekey == 'landarea'}.id.to_s}[0][:comment].to_i

    
    title = "#{rooms} pièces"
    title = "#{title}, #{bedrooms} chambres" 
    title = "#{title}, #{livingarea.round(0)}m2" 
    # title = "#{title}, terrain #{landarea}m2"  

    params[:propertybuyad][:classifiedad_attributes][:title] = title
  end

  def calcul_reward ()
    budget =  params[:propertybuyad][:budget].to_i
    fixedreward =  params[:propertybuyad][:classifiedad_attributes][:fixedreward]
    rewardPro =  params[:propertybuyad][:classifiedad_attributes][:rewardPro].to_d
    rewardInd =  params[:propertybuyad][:classifiedad_attributes][:rewardInd].to_d
    rewardProPercent =  params[:propertybuyad][:classifiedad_attributes][:rewardProPercent]
    rewardIndPercent =  params[:propertybuyad][:classifiedad_attributes][:rewardIndPercent]
        
    if fixedreward == "true"
      params[:propertybuyad][:classifiedad_attributes][:rewardProPercent] = (rewardPro/budget*100).round(2)
      params[:propertybuyad][:classifiedad_attributes][:rewardIndPercent] = (rewardInd/budget*100).round(2)
      puts params[:propertybuyad][:classifiedad_attributes][:rewardIndPercent].inspect
    else
      params[:propertybuyad][:classifiedad][:rewardPro] = (rewardProPercent/100*budget).round
      params[:propertybuyad][:classifiedad][:rewardInd] = (rewardIndPercent/100*budget).round
      puts params[:propertybuyad][:classifiedad][:rewardInd] .inspect
    end

  end

  def classifiedad_params
    params.require(:propertybuyad).permit(classifiedad_attributes: [:title,:short_description,:fixedreward, :sector, :rewardPro, :rewardProPercent,:rewardInd, :rewardIndPercent])
  end

  def classifiedad2_params
    params.require(:propertybuyad).permit(classifiedad: [:title,:short_description, :sector, :rewardPro, :rewardProPercent,:rewardInd, :rewardIndPercent, localisation_attributes: [:id,:number, :street, :district, :city, :dept, :region ]])
  end

  def localisation_params
      params.require(:propertybuyad).permit(localisation: [:number, :street, :district, :city, :dept, :region ])
  end

  def all_params
    params.require(:propertybuyad).permit(:id,:budget, :supply, :description,
      classifiedad_attributes: [:id ,:title,:short_description,:fixedreward, :sector, :rewardPro, :rewardProPercent,:rewardInd, :rewardIndPercent, 
        localisation_attributes: [:id,:number, :street, :district, :city, :dept, :region ], 
        propertyphotos_attributes: [:id,:title, :type_id, :comment, :image] ],
      propertytypewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy],
      propertystatewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
      propertydetailwishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
      sharedfeaturewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
      insidefeaturewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ],
      outsidefeaturewishes_attributes: [:id, :type_id, :wishlevel, :comment, :_destroy ])
  end

end
