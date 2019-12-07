module Cmor
  module Cms
    module Backend
      class MutationType < GraphQL::Schema::Object
        field :create_page, mutation: Cmor::Cms::Backend::Mutations::CreatePage
        field :update_page, mutation: Cmor::Cms::Backend::Mutations::UpdatePage
        field :delete_page, mutation: Cmor::Cms::Backend::Mutations::DeletePage
      end
    end
  end
end
