module Cmor
  module Blog
    module Backend
      module Resolvers
        class PostsSearch < Cmor::Api::Resolvers::Search::Base
          include Cmor::Api::Resolvers::Search::ActsAsPublishedConcern
          # include SearchObject.module(:graphql)

          # type [Cmor::Blog::Backend::Types::PostType], null: false

          # scope { Cmor::Blog::Post.all }

          def self.resource_type
            Cmor::Blog::Backend::Types::PostType
          end

          def self.resource_class
            Cmor::Blog::Post
          end

          initialize!
        end
      end
    end
  end
end
