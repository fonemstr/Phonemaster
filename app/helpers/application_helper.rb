module ApplicationHelper
	def tab(*args)
    options = {:label => args.first.to_s}
    if args.last.is_a?(Hash)
      options = options.merge(args.pop)
    end
    
    options[:route] ||=  "#{args.first}"

    destination_url =  refinery.send("#{options[:route]}_path")

    #return("") unless url_options_authenticate?(ActionController::Routing::Routes.recognize_path(destination_url))

    ## if more than one form, it'll capitalize all words
    label_with_first_letters_capitalized = options[:label].gsub(/\b\w/){$&.upcase}

    link = link_to(label_with_first_letters_capitalized, destination_url)

    css_classes = []

    selected = if options[:match_path]
      logger.info  "******* #{request.fullpath} ********"
      "#{request.fullpath}".starts_with?("#{options[:match_path]}")
    else
      args.include?(controller.controller_name.to_sym)
    end
    css_classes << 'active' if selected

    if options[:css_class]
      css_classes << options[:css_class]
    end
    content_tag('li', link, :class => css_classes.join(' '))
  end 

end
