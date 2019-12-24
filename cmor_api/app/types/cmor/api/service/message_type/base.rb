module Cmor
  module Api
    module Service
      module MessageType
        class Base < GraphQL::Schema::Object
          description "A user-readable message"

          field :indent_level, GraphQL::Types::Int, null: false,
            description: "The indentation level of the message"
          field :prefix, String, null: false,
            description: "The prefix of the message (class name of the service)"
          field :suffix, String, null: true,
            description: "The suffix of the message"
          field :content, String, null: false,
            description: "The message content"
        end
      end
    end
  end
end