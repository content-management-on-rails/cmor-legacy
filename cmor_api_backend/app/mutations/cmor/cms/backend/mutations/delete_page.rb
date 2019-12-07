module Cmor
  module Cms
    module Backend
      module Mutations
        class DeletePage < Cmor::Api::Mutations::Resources::Delete::Base
          include Cmor::Api::SchemaObjects::AuthenticationConcern

          def self.resource_class
            Cmor::Cms::Page
          end

          def self.resource_field_type
            Cmor::Cms::PageType
          end

          initialize!

          argument :id, ID, required: true
        end
      end
    end
  end
end