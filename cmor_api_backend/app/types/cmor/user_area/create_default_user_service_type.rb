module Cmor
  module UserArea
    class CreateDefaultUserServiceType < Cmor::Api::ResourceType::Base
      def self.resource_class
        Cmor::UserArea::User
      end

      field :result, GraphQL::Types::JSON, null: true
      field :errors, GraphQL::Types::JSON, null: true
      field :messages, GraphQL::Types::JSON, null: true
    end
  end
end
