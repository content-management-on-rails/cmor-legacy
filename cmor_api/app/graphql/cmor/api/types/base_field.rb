module Cmor
  module Api
    module Backend
      module Types
        class BaseField < GraphQL::Schema::Field
          argument_class Types::BaseArgument
        end
      end
    end
  end
end
