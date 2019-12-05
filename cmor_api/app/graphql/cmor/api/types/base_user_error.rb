module Cmor
  module Api
    module Types
      class BaseUserError < Types::BaseObject
        description "A user-readable error"

        field :message, String, null: false,
          description: "A description of the error"
        field :path, [String], null: true,
          description: "Which input value this error came from"
      end
    end
  end
end
