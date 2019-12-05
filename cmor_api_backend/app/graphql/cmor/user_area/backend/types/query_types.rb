module Cmor
  module UserArea
    module Backend
      module Types
        module QueryTypes
          def self.register(query_type)
            # queries are just represented as fields
            # `all_links` is automatically camelcased to `allLinks`
            query_type.field :users, [Cmor::UserArea::Backend::Types::UserType], null: false
            query_type.field :user, [Cmor::UserArea::Backend::Types::UserType], null: false

            query_type.send(:include, InstanceMethods)
          end

          module InstanceMethods
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
  end
end
