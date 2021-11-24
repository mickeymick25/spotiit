class Reward < ApplicationRecord


    belongs_to :classifiedad
    belongs_to :type

    accepts_nested_attributes_for :classifiedad, allow_destroy: true

    public
    def is_pro?
        true if type = 1 rescue false
    end
end
