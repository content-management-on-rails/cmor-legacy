module Cmor
  module Api
    module Frontend
      module Types
        class QueryType < Types::BaseObject
          # Add root-level fields here.
          # They will be entry points for queries on your schema.

          include Cmor::Blog::Types::QueryTypeConcern
          include Cmor::UserArea::Types::QueryTypeConcern
          include Cmor::Cms::Types::QueryTypeConcern
        end
      end
    end
  end
end
