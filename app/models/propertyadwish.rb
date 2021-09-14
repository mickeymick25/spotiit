class Propertyadwish < ApplicationRecord
    
    belongs_to :propertybuyad, optional: true

    belongs_to :type

    validates :type_id, uniqueness: { scope: :propertytypewish_id, message: " Vous ne pouvez définir plusieurs souhaits pour un même type de bien."}
    validates :type_id, uniqueness: { scope: :propertystatewish_id, message: " Vous ne pouvez définir plusieurs souhaits pour une même nature de bien."}
    validates :type_id, uniqueness: { scope: :propertydetailwish_id, message: " Vous ne pouvez définir plusieurs souhaits pour une même caracteristique du bien."}
    validates :type_id, uniqueness: { scope: :insidefeaturewish_id, message: " Vous ne pouvez définir plusieurs souhaits pour une même commodité intérieure."}
    validates :type_id, uniqueness: { scope: :outsidefeaturewish_id, message: " Vous ne pouvez définir plusieurs souhaits pour une même commodité exterieure."}
    validates :type_id, uniqueness: { scope: :sharedfeaturewish_id, message: " Vous ne pouvez définir plusieurs souhaits pour une même commodité commune."}
end
