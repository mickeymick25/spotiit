class Propertyadwish < ApplicationRecord
    
    enum level: {
            "Non défini": 0,
            "Obligatoire": 4,
            "Souhaité": 3,
            "Un plus": 2,
            "Rédhibitoire": 1}

    belongs_to :propertybuyad, optional: true

    belongs_to :type

    validates :type_id, uniqueness: { scope: [:propertytypewish_id,:propertystatewish_id, :propertydetailwish_id,:insidefeaturewish_id,:outsidefeaturewish_id,:sharedfeaturewish_id ], message: "Vous ne pouvez définir plusieurs souhaits pour une même caractéristique."}

end
