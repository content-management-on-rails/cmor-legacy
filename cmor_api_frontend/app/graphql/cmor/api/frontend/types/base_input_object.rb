module Cmor
  module Api
    module Frontend
      module Types
        class BaseInputObject < GraphQL::Schema::InputObject
          argument_class Types::BaseArgument
        end
      end
    end
  end
end
