module Cmor
  module UserArea
    module Backend
      module Types
        class UserType < Cmor::Api::Types::Resource::Base
          def self.resource_class
            Cmor::UserArea::User
          end

          infer_fields_from_resource_class!(always_allow_null: true)
        end
      end
    end
  end
end
