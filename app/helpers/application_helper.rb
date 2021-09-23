module ApplicationHelper

    def link_to_add_fields2(name = nil, f = nil, association = nil, options = nil, html_options = nil, &block)
        # If a block is provided there is no name attribute and the arguments are
        # shifted with one position to the left. This re-assigns those values.
        f, association, options, html_options = name, f, association, options if block_given?
      
        options = {} if options.nil?
        html_options = {} if html_options.nil?
      
        if options.include? :locals
          locals = options[:locals]
        else
          locals = { }
        end

        if options.include? :partial
          partial = options[:partial]
        else
          partial = association.to_s.singularize + '_fields'
          # partial = 'inputwish_fields'
        end
      
        # Render the form fields from a file with the association name provided
        new_object = f.object.class.reflect_on_association(association).klass.new
        fields = f.fields_for(association, new_object, child_index: 'new_record',) do |builder|
          render(partial, locals.merge!( f: builder))
        end
        
        # The rendered fields are sent with the link within the data-form-prepend attr
        html_options['id'] = 'data-form-prepend'
        html_options['data-form-prepend'] = raw CGI::escapeHTML( fields )
        html_options['href'] = '#'
        html_options['data-turbolinks'] = 'false'
       
        content_tag(:a, name, html_options, &block)
      end

      def link_to_add_fields(name, f, association)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
          render(association.to_s.singularize + "_fields", f: builder)
        end
        link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
      end

      # Displays the errors for a model instance if there are any
      def display_errors_for(object)
        return unless object.errors.any?

        render partial: 'shared/errors',  
                locals: { object: object }
      end

end
