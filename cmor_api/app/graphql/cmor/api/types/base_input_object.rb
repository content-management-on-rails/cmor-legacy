module Cmor
  module Api
    module Backend
      module Types
        class BaseInputObject < GraphQL::Schema::InputObject
          argument_class Types::BaseArgument
        end
      end
    end
  end
end
