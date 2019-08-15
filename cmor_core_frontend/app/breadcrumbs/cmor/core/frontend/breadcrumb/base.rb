module Cmor
  module Core
    module Frontend
      module Breadcrumb
        class Base
          extend ActiveModel::Model
          attr_accessor :label, :url, :link_html_options, :li_html_options
          
          def initialize(attrs)
            attrs.reverse_merge!(link_html_options: {}, li_html_options: {})
            attrs.each do |k, v|
              self.send("#{k}=", v)
            end
          end
        end
      end
    end
  end
end
