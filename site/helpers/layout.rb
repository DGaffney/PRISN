module LayoutHelper  
  def include_css(*files)
    if files.last.is_a?(Hash)
      options = files.pop
    else
      options = {}
    end
    files.collect{|f| 
      timestamp = File.mtime(File.join(File.dirname(__FILE__), '..', 'public', 'css', f)).to_i
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/#{f}?#{timestamp}\"#{options.keys.empty? ? '' : ' ' + options.each_pair.collect{|k, v| k.to_s+'="'+v+'"'}.join(' ')}>"
    }.join("\n")
  end

  def include_js(*files)
    files.collect{|f|
      timestamp = File.mtime(File.join(File.dirname(__FILE__), '..', 'public', 'js', f)).to_i
      "<script src=\"/js/#{f}?#{timestamp}\"></script>"
    }.join("\n")
  end
  
  def partial(template, *args)
    options = args.extract_options!
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        buffer << erb(path_to_partial_path(template), options.merge(
                                  :layout => false, 
                                  :locals => {path_to_partial_path(template) => member}
                                )
                     )
      end.join("\n")
    else
      erb path_to_partial_path(template), options
    end
  end
    
  def path_to_partial_path(path)
    #converts string of /partial/path to /partial/_path symbol
    broken_path = path.split("/")
    partial_file = "_"+broken_path.last
    return (broken_path[0..-2]|[partial_file]).join("/").to_sym
  end
  
  def erb_path_for(action)
    case action
    when "admin_index"
      return (Dir[File.dirname(__FILE__) + "/views/admin/#{params[:model].singularize}/*"].empty? ? "/admin/default/index" : Dir[File.dirname(__FILE__) + "/views/admin/#{params[:model].singularize}/*"].first).to_sym
    when "admin_show"
      return (Dir[File.dirname(__FILE__) + "/views/admin/#{params[:model].singularize}/*"].empty? ? "/admin/default/show" : Dir[File.dirname(__FILE__) + "/views/#{params[:model].singularize}/*"].first).to_sym
    end
  end
end
