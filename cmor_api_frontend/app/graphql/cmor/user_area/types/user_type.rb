module Cmor
  module UserArea
    module Types
      class UserType < Cmor::Api::Types::BaseObject
        def self.resource_class
          Cmor::UserArea::User
        end

        infer_fields_from_resource_class!
      end
    end
  end
end
