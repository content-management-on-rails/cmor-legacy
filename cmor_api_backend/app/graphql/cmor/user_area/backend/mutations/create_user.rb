module Cmor
  module UserArea
    module Backend
      module Mutations
        # mutation {
        #   createUser(input:{ email: "test7@domain.local", password: "test1234!", active: true, approved: true, confirmed: true }) {
        #     user {
        #       id
        #     }
        #     errors {
        #       message
        #       path
        #     }
        #   }
        # }
        class CreateUser < Cmor::Api::Mutations::Resource::Create::Base
          def self.resource_class
            Cmor::UserArea::User
          end

          def self.resource_field_type
            Cmor::UserArea::Backend::Types::UserType
          end

          initialize!

          argument :email, String, required: true
          argument :password, String, required: true
          argument :active, Boolean, required: true
          argument :approved, Boolean, required: true
          argument :confirmed, Boolean, required: true

          # def initialize_resource_for_create(attributes)
          #   super
          #   @resource.password_confirmation = attributes[:password]
          # end

          def initialize_resource_for_create(attributes)
            super(attributes.merge(password_confirmation: attributes[:password]))
          end          
        end
      end
    end
  end
end
