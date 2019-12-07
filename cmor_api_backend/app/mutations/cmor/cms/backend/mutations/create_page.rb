module Cmor
  module Cms
    module Backend
      module Mutations
        class CreatePage < Cmor::Api::Mutations::Resources::Create::Base
          include Cmor::Api::SchemaObjects::AuthenticationConcern

          def self.resource_class
            Cmor::Cms::Page
          end

          def self.resource_field_type
            Cmor::Cms::PageType
          end

          initialize!

          argument :basename, String, required: true
          argument :body, String, required: false
          argument :format, String, required: false
          argument :handler, String, required: true
          argument :layout, String, required: false
          argument :locale, String, required: false
          argument :meta_description, String, required: false
          argument :pathname, String, required: true
          argument :title, String, required: true
        end
      end
    end
  end
end