class HomeController < ApplicationController
  def index
    @classifiedads = Classifiedad.includes(:localisation, :propertyphotos, :rewards, :propertyad, propertybuyad: [propertytypewishes: [:type]]).all

    @TotalReward = Reward.sum(:amount)
  end

end
