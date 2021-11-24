class IssuerdashboardController < ApplicationController

ADS_PER_PAGE = 5

  def index

    @page = params.fetch(:page,0).to_i
    
    @classifiedads = Classifiedad.includes(:localisation, :propertyphotos, :rewards, :propertyad, propertybuyad: [propertytypewishes: [:type]]).offset(@page*ADS_PER_PAGE).limit(ADS_PER_PAGE)
  
  end

  def show
    @classifiedad = Classifiedad.find(params[:id])
    puts "##############" + params[:id].inspect
    respond_to do |format|
      format.html { redirect_to issuerdashboard_index_path }
      format.js
    end

  end
end
  