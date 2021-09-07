class Propertyadwish < ApplicationRecord
    
    belongs_to :propertybuyad, optional: true

    belongs_to :type

end
