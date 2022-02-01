module HomeHelper

    def get_property_action(classified)

        if classified.is_buy?
            return "Recherche"
        else
            return "Vend"           
        end
    end

    def get_property_types(classified)

        if classified.propertyad.present?
            return classified.propertyad.propertytype
        else
            title = ""            
            classified.propertybuyad.propertytypewishes.each do |wish|
                title = "#{title} #{wish.type.typeName} ou "
            end
            return title.truncate(title.length-3, omission:"")
        end
    end
    
    def get_hero_text(name)
                
        what = '... <br>'
        stop = 'c’est d’arrêter de chercher !'

        if name == 'propertyads'
            what = 'un acheteur'
            stop = 'c’est d’arrêter de le chercher !'
        elsif name == 'propertybuyads' 
            what = 'son logement'
            stop = 'c’est d’arrêter de le chercher !'
        end
        
        html = "<span class='block text-indigo-600 xl:inline'>#{what}</span logement>
                <span class='block xl:inline'>#{stop} </span>"

        render inline: html
    end

    def format_properties(typekey, long)
        case typekey
        when 'rooms'
            return 'pièces'
        when 'bedrooms'
            return 'chambres'
        when 'livingarea'
            return  long ? "m2 habitable" :  "m2"  
        when 'landarea'
            return  long ? "m2 de tarrain" :  "m2"
        end
    end

    
    
end
