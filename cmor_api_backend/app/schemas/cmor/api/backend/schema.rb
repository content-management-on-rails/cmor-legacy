module Cmor
  module Api
    module Backend
      class Schema < GraphQL::Schema
        # query Cmor::Blog::Backend::PostSchemaObject
        # mutation Cmor::Blog::Backend::MutationType

        # query Cmor::UserArea::Backend::UserSchemaObject
        # mutation Cmor::UserArea::Backend::MutationType

        query Cmor::Api::Backend::Queries
        mutation Cmor::Api::Backend::Mutations
      end
    end
  end
end
