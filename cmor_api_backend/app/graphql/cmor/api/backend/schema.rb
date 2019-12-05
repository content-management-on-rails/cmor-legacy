module Cmor
  module Api
    module Backend
      class Schema < GraphQL::Schema
        mutation(Cmor::Api::Backend::Types::MutationType)
        query(Cmor::Api::Backend::Types::QueryType)
      end
    end
  end
end
