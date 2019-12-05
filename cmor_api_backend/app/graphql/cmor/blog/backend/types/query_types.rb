module Cmor
  module Blog
    module Backend
      module Types
        # @todo https://github.com/rstankov/SearchObjectGraphQL
        class QueryTypes
          def self.register(query_type)
            # queries are just represented as fields
            # `all_links` is automatically camelcased to `allLinks`
            # query_type.field :posts, [::Cmor::Blog::Backend::Types::PostType], null: false
            query_type.field :posts, resolver: ::Cmor::Blog::Backend::Resolvers::PostsSearch
            query_type.field :post, [::Cmor::Blog::Backend::Types::PostType], null: false

            query_type.send(:include, InstanceMethods)
          end

          module InstanceMethods
            def posts
              Cmor::Blog::Post.all
            end

            def post(id:)
              Cmor::Blog::Post.find(id)
            end
          end
        end
      end
    end
  end
end
