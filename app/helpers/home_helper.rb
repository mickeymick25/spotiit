module HomeHelper

    def get_property_title(classified)
        puts "########### get_property_title"

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
end
