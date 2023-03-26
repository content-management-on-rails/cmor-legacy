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
            def serializer_class; end
          end

          private

          def serialize_collection(collection, populate_associations: true)
            {
              data: collection.map { |resource| serialize_resource_for_collection(resource, populate_associations: populate_associations) },
              meta: { attribute_names: resource_class.attribute_names.each_with_object({}) { |an, memo| memo[an] = resource_class.human_attribute_name(an)  } }
            }

          end

        def serialize_resource_for_collection(resource, populate_associations: true)
          json = {}
          json[:id] = resource.id
          json[:attributes] = serializable_object(resource).as_json.except("id")
          json[:attributes].merge!(populate(resource, json)) if populate_associations
          json[:errors] = serialize_errors(resource.errors) if resource.errors.any?
          json
        end

        def serialize_resource(resource, populate_associations: true)
          json = { data: {} }
          json[:data][:id] = resource.id
          json[:data][:attributes] = serializable_object(resource).as_json.except("id")
          json[:data][:attributes].merge!(populate(resource, json)) if populate_associations
          json[:data][:errors] = serialize_errors(resource.errors) if resource.errors.any?
          json
        end

        def serializable_object(resource)
          if self.class.serializer_class.present?
            self.class.serializer_class.new(resource)
          else
            resource
          end
        end

          def serialize_errors(errors)
            errors.as_json(full_messages: true)
          end

          def populate(resource, json)
            [params[:populate]].compact.flatten.each_with_object({}) do |associated, memo|
              record_or_association = resource.send(associated)
              if record_or_association.is_a?(ActiveRecord::Associations::CollectionProxy)
                memo[associated] = serialize_collection(record_or_association, populate_associations: false)
              else
                memo[associated] = serialize_resource(record_or_association, populate_associations: false)
              end
            end
          end
        end
      end
    end
  end
end
