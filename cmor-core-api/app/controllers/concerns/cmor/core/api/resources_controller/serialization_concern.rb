module Cmor
  module Core
    module Api
      module ResourcesController
        # When using the concern along with Rao::Query when you use the populate
        # parameter you will have to add it to the query params exception list.
        #
        # Example:
        #
        #     # config/initializers/rao-query.rb
        #     Rao::Query.configure do |config|
        #       config.default_query_params_exceptions %w(... populate)
        #     end
        #
        module SerializationConcern
          extend ActiveSupport::Concern

          class_methods do
            def serializer_class
              Cmor::Core::Api::Serializer::Base
            end
          end

          private

          def serializer_class
            self.class.serializer_class
          end

          private

          def serialize_resource(resource)
            {
              data: serializer_class.new(resource, params).as_json,
              meta: serialize_meta(resource_class)
            }
          end

          def serialize_collection(collection)
            {
              data: collection.map { |resource| serializer_class.new(resource, params).as_json },
              meta: serialize_meta(resource_class)
            }
          end

          def serialize_meta(resource_class)
            {
              attribute_names: resource_class.attribute_names.each_with_object({}) { |an, memo| memo[an] = resource_class.human_attribute_name(an) }
            }
          end
        end
      end
    end
  end
end
