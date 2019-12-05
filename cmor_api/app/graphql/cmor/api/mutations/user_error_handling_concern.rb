module Cmor
  module Api
    module Mutations
      module UserErrorHandlingConcern
        extend ActiveSupport::Concern

        included do
          field :errors, [Cmor::Api::Types::BaseUserError], null: false
        end
      end
    end
  end
end
