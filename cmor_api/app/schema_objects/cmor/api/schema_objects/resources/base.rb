module Cmor
  module Api
    module SchemaObjects
      module Resources
        # Example:
        #
        #     query {
        #       posts(limit: 1, offset: 2, orderBy: { field: "position", direction: "asc" }) {
        #         body
        #         createdAt
        #         createdById
        #         id
        #         position
        #         publishedAt
        #         slug
        #         title
        #         updatedAt
        #         updatedById
        #       }
        #     }
        class Base < GraphQL::Schema::Object
          class OrderByType < GraphQL::Schema::InputObject
            argument :field, String, required: true,
              description: "What field to order by"
            argument :direction, String, required: true,
              description: "What direction to order by. Either asc or desc."
          end

          def self.resource_class
            raise "Child class responsibilty."
          end

          def resource_class
            self.class.resource_class
          end

          def self.collection_name
            resource_class.name.demodulize.pluralize.underscore.to_sym
          end

          def self.resource_name
            resource_class.name.demodulize.underscore.to_sym
          end

          def self.resource_type
            "#{resource_class.name}Type".constantize
          end

          def self.default_limit
            100
          end

          def load_collection(limit:, offset:)
            self.resource_class.limit(limit).offset(offset).all
          end

          def load_resource(id:)
            self.resource_class.find(id)
          end

          def self.initialize!
            default_limit = self.default_limit
            field collection_name, [resource_type], null: false do
              argument :limit, Integer, required: false, default_value: default_limit, prepare: ->(limit, ctx) { limit }
              argument :offset, Integer, required: false, default_value: 0, prepare: ->(offset, ctx) { offset }
              argument :order_by, OrderByType, required: false, prepare: ->(order_by, ctx) { order_by }
            end
            field resource_name, [resource_type], null: false

            define_method(collection_name) do |limit:, offset:, order_by:|
              scope = load_collection(limit: limit, offset: offset)
              if order_by.present?
                scope = scope.reorder(order_by[:field] => order_by[:direction])
              end
              scope
            end

            define_method(resource_name) do |id:|
              load_resource(id: id)
            end
          end
        end
      end
    end
  end
end
