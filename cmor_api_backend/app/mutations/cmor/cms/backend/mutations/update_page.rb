module Cmor
  module Cms
    module Backend
      module Mutations
        class UpdatePage < Cmor::Api::Mutations::Resources::Update::Base
          include Cmor::Api::SchemaObjects::AuthenticationConcern

          def self.resource_class
            Cmor::Cms::Page
          end

          def self.resource_field_type
            Cmor::Cms::PageType
          end

          initialize!
          
          argument :id, ID, required: true
          argument :basename, String, required: false
          argument :body, String, required: false
          argument :format, String, required: false
          argument :handler, String, required: false
          argument :layout, String, required: false
          argument :locale, String, required: false
          argument :meta_description, String, required: false
          argument :pathname, String, required: false
          argument :title, String, required: false
        end
      end
    end
  end
end