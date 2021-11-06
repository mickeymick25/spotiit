class IssuerdashboardController < ApplicationController

ADS_PER_PAGE = 5

  def index

    @page = params.fetch(:page,0).to_i
    
    @classifiedads = Classifiedad.includes(:localisation, :propertyphotos, :rewards, :propertyad, propertybuyad: [propertytypewishes: [:type]]).offset(@page*ADS_PER_PAGE).limit(ADS_PER_PAGE)
  
  end
end
  