module HomeHelper

    def get_property_title(classified)

        if classified.propertyad.present?
            return "Vend : #{classified.propertyad.propertytype}"
        else
            title = "Cherche : "
            classified.propertybuyad.propertytypewishes.each do |wish|
                title = "#{title} #{wish.type.typeName} ou "
            end
            return title.truncate(title.length-3, omission:"")
        end
    end

    def get_hero_text(name)
                
        bestway = 'La meilleure façon de trouver'
        what = '... <br>'
        stop = 'c’est d’arrêter de chercher !'

        if name == 'propertyads'
            what = 'un acheteur'
            stop = 'c’est d’arrêter de le chercher !'
        elsif name == 'propertybuyads' 
            what = 'son logement'
            stop = 'c’est d’arrêter de le chercher !'
        end
        
        html = "<h1 class='text-4xl tracking-tight font-extrabold text-gray-900 sm:text-5xl md:text-6xl'>
                <span class='block xl:inline'>#{bestway}</span>
                <span class='block text-indigo-600 xl:inline'>#{what}</span logement>
                <span class='block xl:inline'>#{stop} </span>
            </h1>"

        render inline: html
    end

end
