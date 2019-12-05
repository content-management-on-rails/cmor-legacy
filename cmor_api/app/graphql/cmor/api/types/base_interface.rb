module Cmor
  module Api
    module Backend
      module Types
        module BaseInterface
          include GraphQL::Schema::Interface

          field_class Types::BaseField
        end
      end
    end
  end
end
