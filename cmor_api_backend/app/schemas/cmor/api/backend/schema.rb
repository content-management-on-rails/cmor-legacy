module Cmor
  module Api
    module Backend
      class Schema < GraphQL::Schema
        query Cmor::Blog::Backend::PostSchemaObject
        mutation Cmor::Blog::Backend::MutationType

        # query Cmor::UserArea::Backend::UserSchemaObject
        # mutation Cmor::UserArea::Backend::MutationType
      end
    end
  end
end
