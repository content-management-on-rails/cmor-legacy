module Cmor
  module UserArea
    class UserType < Cmor::Api::ResourceType::Base
      def self.resource_class
        Cmor::UserArea::User
      end

      infer_fields_from_resource_class! # (always_allow_null: true)
      field :password, String, null: true
      field :password_confirmation, String, null: true
    end
  end
end
