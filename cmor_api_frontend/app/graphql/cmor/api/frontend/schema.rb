module Cmor
  module Api
    module Frontend
      class Schema < GraphQL::Schema
        mutation(Cmor::Api::Frontend::Types::MutationType)
        query(Cmor::Api::Frontend::Types::QueryType)
      end
    end
  end
end
