class PropertyadsController < ApplicationController
  def index
    @propertyads = Propertyad.all 
  end

  def show
    @propertyad = Propertyad.find(params[:id])
  end

  def edit
    @propertyad = Propertyad.find(params[:id])
  end

  def update
    @propertyad = Propertyad.find(params[:id])
    @propertyad.update(classifedad_params)

    redirect_to propertyads_path and return
  end

  def destroy
    @propertyad = Propertyad.find(params[:id])
    @propertyad.destroy 

    redirect_to propertyads_path
  end

  def new
    @propertyad = Propertyad.new
  end

  def create

    propertyad = Propertyad.create(classifedad_params)
    
    redirect_to propertyad_path(propertyad.id)
  end

  private
  def classifedad_params
    params.require(:propertyad).permit(:netprice ,:livingarea, :landarea ,:rooms ,:bedrooms ,:floor ,:buildingyear, :cmtyheating, :energydiagnostic, :carbon, :availability, :description,
      :orientation, :propertytype,:propertystate)
  end
end
