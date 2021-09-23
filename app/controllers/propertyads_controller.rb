class PropertyadsController < ApplicationController
  def index
    @propertyads = Propertyad.includes(classifiedad: [:localisation, :propertyphotos], adfeatures: [:type]).all 
  end

  def show
    @propertyad = Propertyad.includes(classifiedad: [:localisation,:propertyphotos], adfeatures: [:type]).find(params[:id])
  end

  def edit
    @propertyad = Propertyad.includes(classifiedad: [:localisation,:propertyphotos], adfeatures: [:type]).find(params[:id])
    
    set_featureids
  end

  def update

    @propertyad = Propertyad.includes(classifiedad: [:localisation,:propertyphotos], adfeatures: [:type]).find(params[:id])
    
    @propertyad.classifiedad.assign_attributes(classifiedad_params[:classifiedad_attributes] )
    
    @propertyad.classifiedad.valid?    

    if @propertyad.classifiedad.errors.count > 0
      render 'edit' and return
    end
    
    calcul_reward()
      
    self.calcul_reward 
    
    if @propertyad.update(all_params)
        puts "update------------------------------ca a marché"
        
        @propertyad.classifiedad.propertyphotos.each do |photo|
          photo.image_derivatives!
          photo.save
        end

        redirect_to propertyads_path and return
    else
      
      set_featureids
      render 'edit' 
    end
  end

  def destroy
    @propertyad = Propertyad.find(params[:id])
    @propertyad.destroy 

    redirect_to propertyads_path
  end

  def new
    
    puts "############### new"
    @propertyad = Propertyad.new
    
    @propertyad.classifiedad = Classifiedad.new
    
    @propertyad.classifiedad.localisation = Localisation.new

    init_adfeatures @propertyad

    set_featureids

    @insidefeatures = @propertyad.adfeatures. where(type_id: Type.select(:id).where(catetory: 'insidefeatures'))
  end

  def create

    puts "Create Propertyad ###################################"

    propertyad = Propertyad.new (all_params)

    propertyad.classifiedad.sector = "Immobilier"
    propertyad.classifiedad.adstatus = "to_validate"
    

    @propertyad.classifiedad.assign_attributes(classifiedad_params[:classifiedad_attributes] )
    
    @propertyad.classifiedad.valid?    

    if @propertyad.classifiedad.errors.count > 0
      render 'edit' and return
    end
    
    self.calcul_reward()

    if propertyad.save
        puts "save------------------------------ca a marché"
        redirect_to propertyads_path and return
    else
        puts "save------------------------------ca n'a pas marché"
        @propertyad = propertyad
        init_adfeatures (@propertyad)
        set_featureids
        render 'new'
    end
    
  end

  private

  def set_featureids
    @insideids = Type.select(:id).where(catetory: 'insidefeatures').ids
    @outsideids = Type.select(:id).where(catetory: 'outsidefeatures').ids
    @sharedids = Type.select(:id).where(catetory: 'sharedfeatures').ids
  end

  def classifiedad_params
    params.require(:propertyad).permit(classifiedad_attributes: [:title,:short_description,:fixedreward, :sector, :rewardPro, :rewardProPercent,:rewardInd, :rewardIndPercent])
  end

  def all_params
    params.require(:propertyad).permit(:id,:netprice ,:livingarea,
      :landarea ,:rooms ,:bedrooms ,:floor ,:buildingyear, :cmtyheating, :energydiagnostic, :carbon, :availability, 
      :description, :orientation, :propertytype,:propertystate,
      classifiedad_attributes: [:id ,:title,:short_description,:fixedreward, :sector, :rewardPro, :rewardProPercent,:rewardInd, :rewardIndPercent, 
      localisation_attributes: [:id,:number, :street, :district, :city, :dept, :region ], 
      propertyphotos_attributes: [:id,:title, :type_id, :comment, :image]],
    adfeatures_attributes: [:id,:selected, :type_id, :comment, :_destroy])
  end

  def init_adfeatures (propertyad)
    Type.all.each do |type|
      if type.catetory == "sharedfeatures"
        propertyad.adfeatures.new().type = type
      elsif type.catetory == "insidefeatures"
        propertyad.adfeatures.new().type = type
      elsif type.catetory == "outsidefeatures"
        propertyad.adfeatures.new().type = type
      end
    end
  end

  def calcul_reward ()
    netprice =  params[:propertyad][:netprice].to_i
    fixedreward =  params[:propertyad][:classifiedad_attributes][:fixedreward]
    rewardPro =  params[:propertyad][:classifiedad_attributes][:rewardPro].to_d
    rewardInd =  params[:propertyad][:classifiedad_attributes][:rewardInd].to_d
    rewardProPercent =  params[:propertyad][:classifiedad_attributes][:rewardProPercent]
    rewardIndPercent =  params[:propertyad][:classifiedad_attributes][:rewardIndPercent]
    
    if fixedreward == "true"
      puts fixedreward.inspect
      params[:propertyad][:classifiedad_attributes][:rewardProPercent] = (rewardPro/netprice*100).round(2)
      params[:propertyad][:classifiedad_attributes][:rewardIndPercent] = (rewardInd/netprice*100).round(2)
      puts params[:propertyad][:classifiedad_attributes][:rewardIndPercent].inspect
    else
      puts fixedreward.inspect
      params[:propertyad][:classifiedad][:rewardPro] = (rewardProPercent/100*netprice).round
      params[:propertyad][:classifiedad][:rewardInd] = (rewardIndPercent/100*netprice).round
      puts params[:propertyad][:classifiedad][:rewardInd] .inspect
    end

  end

end
