class PropertyadsController < ApplicationController
  def index
    puts "###################" + current_user.inspect
    if current_user.nil?
      @classifiedads = Classifiedad.includes(:localisation, :propertyphotos, :rewards, propertybuyad: [adfeatures: [:type]]).left_outer_joins(:propertybuyad).where('propertybuyads.classifiedad_id is null')
      
      ids = Classifiedad.left_outer_joins(:propertybuyad).where('propertybuyads.classifiedad_id is null').select(:id).to_a.to_formatted_s(:db)
      @TotalReward = Reward.joins(:classifiedad).where("classifiedads.id in (#{ids})").sum(:amount)
    else
      @propertyads = Propertyad.includes(classifiedad: [:localisation, :rewards, :propertyphotos], adfeatures: [:type]).joins(:classifiedad).where("classifiedads.user_id = #{current_user.id}") 
    end
  end

  def show
    @propertyad = Propertyad.includes(classifiedad: [:localisation, :rewards,:propertyphotos], adfeatures: [:type]).find(params[:id])
  end

  def edit
    @propertyad = Propertyad.includes(classifiedad: [:localisation, :rewards,:propertyphotos], adfeatures: [:type]).find(params[:id])
    
    if @propertyad.classifiedad.rewards.count == 0
      @propertyad.classifiedad.rewards.new()
    end
    set_featureids
  end

  def update

    puts "update Propertyad ###################################"

    @propertyad = Propertyad.includes(classifiedad: [:localisation,:propertyphotos], adfeatures: [:type]).find(params[:id])
    
    # @propertyad.classifiedad.assign_attributes(classifiedad_params[:classifiedad_attributes] )
    
    classifiedad = Classifiedad.new(classifiedad_params[:classifiedad_attributes])
    
    classifiedad.valid?    

    if classifiedad.valid?
      calcul_reward()
    end
    
    self.set_title
    
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
    
    puts  @propertyad.classifiedad.inspect
    puts  @propertyad.inspect
    @propertyad.classifiedad.localisation = Localisation.new

    @propertyad.classifiedad.rewards.new()

    init_adfeatures @propertyad

    set_featureids

    # @insidefeatures = @propertyad.adfeatures. where(type_id: Type.select(:id).where(catetory: 'insidefeatures'))
  end

  def create

    puts "Create Propertyad ###################################"

    propertyad = Propertyad.new (all_params)

    propertyad.classifiedad.sector = "Immobilier"
    propertyad.classifiedad.adstatus = "to_validate"
    propertyad.classifiedad.title = ""
    propertyad.classifiedad.user_id = current_user.id
    
    #propertyad.classifiedad.assign_attributes(classifiedad_params[:classifiedad_attributes] )
    
    if propertyad.classifiedad.valid?
      propertyad.classifiedad.rewards[0].amount = self.calcul_reward()
    end
    
    propertyad.classifiedad.title = self.set_title()
    
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
    # params.require(:propertyad).permit(classifiedad_attributes: [:title,:short_description,:fixedreward, :sector, :rewardPro, :rewardProPercent,:rewardInd, :rewardIndPercent])
    params.require(:propertyad).permit(classifiedad_attributes: [:id,:title,:short_description,:fixedreward, :sector, rewards_attributes:[:percent, :amount]])
  end

  def all_params
    params.require(:propertyad).permit(:id,:netprice ,:livingarea,
      :landarea ,:rooms ,:bedrooms ,:floor ,:buildingyear, :cmtyheating, :energydiagnostic, :carbon, :availability, 
      :description, :orientation, :propertytype,:propertystate,
      classifiedad_attributes: [:id ,:title,:short_description,:fixedreward, :sector, rewards_attributes:[:id, :percent, :amount], 
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


  def set_title ()

    puts "set_title #################"
    propertytype =   params[:propertyad][:propertytype]
    rooms =   params[:propertyad][:rooms]
    bedrooms =   params[:propertyad][:bedrooms]
    livingarea =   params[:propertyad][:livingarea].to_d
    landarea =   params[:propertyad][:landarea]
    
    title = "#{rooms} pièces"
    title = "#{title}, #{bedrooms} chambres" if !bedrooms.empty?
    title = "#{title}, #{livingarea.round(0)}m2" if !livingarea.nil?
    title = "#{title}, terrain #{landarea}m2" if !landarea.empty? 

    params[:propertyad][:classifiedad_attributes][:title] = title
    
    puts "title = " + title

    return title
  end

  def calcul_reward ()

    puts "calcul_reward #################"
    netprice =  params[:propertyad][:netprice].to_i
    rewardPercent = params[:propertyad][:classifiedad_attributes][:rewards_attributes]['0'][:percent].to_d
    
    rewardAmount = ((rewardPercent*netprice/100)/100).ceil * 100
    params[:propertyad][:classifiedad_attributes][:rewards_attributes]['0'][:amount] = rewardAmount
    
    # fixedreward =  params[:propertyad][:classifiedad_attributes][:fixedreward]
    # rewardPro =  params[:propertyad][:classifiedad_attributes][:rewardPro].to_d
    # rewardInd =  params[:propertyad][:classifiedad_attributes][:rewardInd].to_d
    # rewardProPercent =  params[:propertyad][:classifiedad_attributes][:rewardProPercent]
    # rewardIndPercent =  params[:propertyad][:classifiedad_attributes][:rewardIndPercent]
    
    # if fixedreward == "true"
    #   params[:propertyad][:classifiedad_attributes][:rewardProPercent] = (rewardPro/netprice*100).round(2)
    #   params[:propertyad][:classifiedad_attributes][:rewardIndPercent] = (rewardInd/netprice*100).round(2)
    #   puts params[:propertyad][:classifiedad_attributes][:rewardIndPercent].inspect
    # else
    #   params[:propertyad][:classifiedad][:rewardPro] = (rewardProPercent/100*netprice).round
    #   params[:propertyad][:classifiedad][:rewardInd] = (rewardIndPercent/100*netprice).round
    #   puts params[:propertyad][:classifiedad][:rewardInd] .inspect
    # end
    
    return rewardAmount
  end

end
