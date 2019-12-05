module Cmor
  module UserArea
    module Backend
      module Mutations
        module MutationTypeConcern
          extend ActiveSupport::Concern

          included do
            field :create_user, mutation: Cmor::UserArea::Backend::Mutations::CreateUser
            field :sign_in_user, mutation: Cmor::UserArea::Backend::Mutations::SignInUser
          end
        end
      end
    end
  end
end
