module Cmor
  module UserArea
    module Backend
      module Mutations
        class UpdateUser < Cmor::Api::Mutations::Resources::Update::Base
          include Cmor::Api::SchemaObjects::AuthenticationConcern

          def self.resource_class
            Cmor::UserArea::User
          end

          def self.resource_field_type
            Cmor::UserArea::UserType
          end

          initialize!

          argument :id, ID, required: false
          argument :email, String, required: false
          argument :password, String, required: false
          argument :password_confirmation, String, required: false
          # argument :password_salt, String, required: false
          argument :password_salt, String, required: false
          argument :persistence_token, String, required: false
          argument :single_access_token, String, required: false
          argument :perishable_token, String, required: false
          argument :login_count, Integer, required: false
          argument :failed_login_count, Integer, required: false
          argument :last_request_at, GraphQL::Types::ISO8601DateTime, required: false
          argument :current_login_at, GraphQL::Types::ISO8601DateTime, required: false
          argument :last_login_at, GraphQL::Types::ISO8601DateTime, required: false
          argument :current_login_ip, String, required: false
          argument :last_login_ip, String, required: false
          argument :active, Boolean, required: false
          argument :approved, Boolean, required: false
          argument :confirmed, Boolean, required: false
        end
      end
    end
  end
end