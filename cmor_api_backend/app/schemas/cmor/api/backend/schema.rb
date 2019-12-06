module Cmor
  module Api
    module Backend
      class Schema < GraphQL::Schema
        query Cmor::Blog::Backend::PostSchemaObject
      end
    end
  end
end
