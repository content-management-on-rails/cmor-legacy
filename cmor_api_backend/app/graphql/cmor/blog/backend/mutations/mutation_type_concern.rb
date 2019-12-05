module Cmor
  module Blog
    module Backend
      module Mutations
        module MutationTypeConcern
          extend ActiveSupport::Concern

          included do
            field :create_post, mutation: Cmor::Blog::Backend::Mutations::CreatePost
          end
        end
      end
    end
  end
end
