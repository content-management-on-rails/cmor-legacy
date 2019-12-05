module Cmor
  module Blog
    module Types
      module QueryTypeConcern
        extend ActiveSupport::Concern

        included do
          # queries are just represented as fields
          # `all_links` is automatically camelcased to `allLinks`
          field :posts, [::Cmor::Blog::Types::PostType], null: false
          field :post, [::Cmor::Blog::Types::PostType], null: false
        end

        # this method is invoked, when `all_link` fields is being resolved
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
