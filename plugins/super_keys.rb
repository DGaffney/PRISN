module SuperKeys
  extend ActiveSupport::Concern

  module ClassMethods
    def admin_table_keys
      return []
    end
    
    def associative_keys
      Hash[self.associations.collect{|method, association| [method, association.options[:in]]}].invert
    end
  end

  module InstanceMethods
    def is_associative?(key)
      return self.class.associative_keys.include?(key.to_sym)
    end
    
    def associative_url_path_admin(key, value)
      return "/admin/#{self.class.associative_keys[key]}/#{value}"
    end
  end
end
MongoMapper::Document.plugin(SuperKeys)