module Cmor
  module Blog
    module Backend
      module Mutations
        #
        # header['Authorization'] = Bearer: <your-bearer-token-from-sign-in-user-here>
        #
        # mutation {
        #   createPost(input: {title: "This is a post from the GraphQL api", body: "Lorem Ipsum.", publishedAt: "20191203T233800+0100"}) {
        #     post {
        #       id
        #       title
        #     }
        #     errors {
        #       message
        #       path
        #     }
        #   }
        # }
        #
        class CreatePost < Cmor::Api::Mutations::Resource::Create::Base
          include Cmor::Api::AuthenticationConcern

          def self.resource_class
            Cmor::Blog::Post
          end

          def self.resource_field_type
            Cmor::Blog::Backend::Types::PostType
          end

          initialize!

          argument :title, String, required: true
          argument :body, String, required: true
          argument :published_at, GraphQL::Types::ISO8601DateTime, required: false

          private

          def initialize_resource_for_create(attributes)
            super(attributes.merge(created_by_id: context[:current_user].id))
          end 

          def before_resolve
            check_authentication!
          end
        end
      end
    end
  end
end
