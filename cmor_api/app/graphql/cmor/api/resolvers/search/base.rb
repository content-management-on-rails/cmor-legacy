module Cmor
  module Api
    module Resolvers
      module Search
        class Base
          include SearchObject.module(:graphql)

          def self.resource_type
            raise "Child class responsibility."
          end

          def self.resource_class
            raise "Child class responsibility."
          end

          def self.initialize!
            type [self.resource_type], null: false
            scope { self.class.resource_class.all }
          end

          module ActsAsPublishedConcern
            extend ActiveSupport::Concern

            included do
              option(:published, type: GraphQL::Schema::Object::Boolean) { |scope, value| value ? scope.published : scope.unpublished }
            end
          end

          module OrderConcern
            extend ActiveSupport::Concern

            class OrderType < Types::BaseObject
          graphql_name "Foo"

              description "OrderBy parameters"

              field :field, String, null: false, description: "The field you want to order by."
              field :direction, String, null: false, description: "The direction you want to order by. Either asc or desc."
            end

            included do
              option(:order_by, type: Cmor::Api::Resolvers::Search::Base::OrderConcern::OrderType) { |scope, value| value ? scope.order(value) : scope }
            end
          end

          include OrderConcern
        end
      end
    end
  end
end
