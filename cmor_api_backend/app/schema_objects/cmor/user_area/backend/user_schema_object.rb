module Cmor
  module UserArea
    module Backend
      class UserSchemaObject < Cmor::Api::SchemaObjects::Resources::Base
        def self.resource_class
          Cmor::UserArea::User
        end

        initialize!
      end
    end
  end
end
