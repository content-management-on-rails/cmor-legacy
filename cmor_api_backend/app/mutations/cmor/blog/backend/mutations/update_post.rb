module Cmor
  module Blog
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
        class UpdatePost < Cmor::Api::Mutations::Resources::Update::Base
          include Cmor::Api::SchemaObjects::AuthenticationConcern

          def self.resource_class
            Cmor::Blog::Post
          end

          def self.resource_field_type
            Cmor::Blog::PostType
          end

          initialize!

          argument :id, ID, required: true
          argument :title, String, required: true
          argument :body, String, required: true
          argument :published_at, GraphQL::Types::ISO8601DateTime, required: false

          private

          module UserstampConcern
            extend ActiveSupport::Concern

            private

            def initialize_resource_for_create(attributes)
              super(attributes.merge(created_by_id: context[:current_user].id))
            end

            def initialize_resource_for_udpate(attributes)
              super(attributes.merge(updated_by_id: context[:current_user].id))
            end

            def before_resolve
              check_authentication!
            end
          end

          include UserstampConcern
        end
      end
    end
  end
end