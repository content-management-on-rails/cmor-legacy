module Cmor
  module Core
    module Frontend
      module Breadcrumb
        module Path
          class Base
            extend ActiveModel::Model
            include I18nConcern

            attr_accessor :context

            def initialize(attrs)
              attrs.each do |k, v|
                self.send("#{k}=", v)
              end
            end

            def breadcrumbs
              raise "Child class reponsibility"
            end
          end
        end
      end
    end
  end
end