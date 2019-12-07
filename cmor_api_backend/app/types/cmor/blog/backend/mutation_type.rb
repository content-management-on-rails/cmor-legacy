module Cmor
  module Blog
    module Backend
      class MutationType < GraphQL::Schema::Object
        field :create_page, mutation: Cmor::Blog::Backend::Mutations::CreatePost
        field :update_post, mutation: Cmor::Blog::Backend::Mutations::UpdatePost
        field :delete_post, mutation: Cmor::Blog::Backend::Mutations::DeletePost
      end
    end
  end
end
