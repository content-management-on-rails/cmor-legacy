module Cmor
  module Cms
    module Backend
      module Types
        class PageType < Cmor::Api::Types::Resource::Base
          def self.resource_class
            Cmor::Cms::Page
          end

          infer_fields_from_resource_class!
        end
      end
    end
  end
end
