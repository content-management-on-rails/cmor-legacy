module Cmor
  module UserArea
    module Backend
      module Mutations
        #
        # header['Authorization'] = Bearer: <your-bearer-token-from-sign-in-user-here>
        #
        # mutation {
        #   updatePost(input: {title: "This is the updated title"}) {
        #     post {
        #       id
        #       updatedById
        #     }
        #     errors {
        #       message
        #       path
        #     }
        #   }
        # }
        #
        class DeleteUser < Cmor::Api::Mutations::Resources::Delete::Base
          include Cmor::Api::SchemaObjects::AuthenticationConcern

          def self.resource_class
            Cmor::UserArea::User
          end

          def self.resource_field_type
            Cmor::UserArea::UserType
          end

          initialize!

          argument :id, ID, required: true
        end
      end
    end
  end
end