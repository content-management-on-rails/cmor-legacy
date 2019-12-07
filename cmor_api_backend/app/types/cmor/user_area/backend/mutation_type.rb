module Cmor
  module UserArea
    module Backend
      class MutationType < GraphQL::Schema::Object
        field :create_user, mutation: Cmor::UserArea::Backend::Mutations::CreateUser
        field :update_user, mutation: Cmor::UserArea::Backend::Mutations::UpdateUser
        field :delete_user, mutation: Cmor::UserArea::Backend::Mutations::DeleteUser
      end
    end
  end
end
