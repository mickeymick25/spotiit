class HomeController < ApplicationController
  def index
    @classifiedads = Classifiedad.includes(:localisation, :propertyphotos, :propertyad, propertybuyad: [propertytypewishes: [:type]]).all
  end

end
