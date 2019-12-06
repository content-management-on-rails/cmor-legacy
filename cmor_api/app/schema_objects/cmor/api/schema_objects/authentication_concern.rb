module Cmor
  module Api
    module SchemaObjects
      module AuthenticationConcern
        extend ActiveSupport::Concern

        def check_authentication!
          return if context[:current_user]

          raise GraphQL::ExecutionError,
                "You need to authenticate to perform this action"
        end
      end
    end
  end
end
