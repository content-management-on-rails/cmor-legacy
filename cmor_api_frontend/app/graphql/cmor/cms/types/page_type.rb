module Cmor
  module Cms
    module Types
      class PageType < Cmor::Api::Types::BaseObject
        def self.resource_class
          Cmor::Cms::Page
        end

        infer_fields_from_resource_class!
      end
    end
  end
end
