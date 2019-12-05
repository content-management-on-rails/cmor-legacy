module Cmor
  module Api
    module Backend
      module Types
        class QueryType < Cmor::Api::Types::BaseObject
          # Add root-level fields here.
          # They will be entry points for queries on your schema.

          # include Cmor::Blog::Backend::Types::QueryTypeConcern
          Cmor::Blog::Backend::Types::QueryTypes.register(self)
          # include Cmor::UserArea::Backend::Types::QueryTypeConcern
          Cmor::UserArea::Backend::Types::QueryTypes.register(self)
          # include Cmor::Cms::Backend::Types::QueryTypeConcern
          Cmor::Cms::Backend::Types::QueryTypes.register(self)
        end
      end
    end
  end
end
