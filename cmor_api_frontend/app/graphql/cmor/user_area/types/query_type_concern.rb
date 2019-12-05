module Cmor
  module UserArea
    module Types
      module QueryTypeConcern
        extend ActiveSupport::Concern

        included do
          # queries are just represented as fields
          # `all_links` is automatically camelcased to `allLinks`
          field :users, [Cmor::UserArea::Types::UserType], null: false
          field :user, [Cmor::UserArea::Types::UserType], null: false
        end

        # this method is invoked, when `all_link` fields is being resolved
        def users
          Cmor::UserArea::User.all
        end

        def user(id:)
          Cmor::UserArea::User.find(id)
        end
      end
    end
  end
end
