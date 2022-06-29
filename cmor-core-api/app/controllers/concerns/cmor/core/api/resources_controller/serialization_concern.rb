module Cmor
  module Core
    module Api
      module ResourcesController
        module SerializationConcern
          extend ActiveSupport::Concern

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
            json[:attributes] = resource.as_json.except("id")
            json[:attributes].merge!(populate(resource, json)) if populate_associations
            json[:errors] = serialize_errors(resource.errors) if resource.errors.any?
            json
          end

          def serialize_resource(resource, populate_associations: true)
            json = { data: {} }
            json[:data][:id] = resource.id
            json[:data][:attributes] = resource.as_json.except("id")
            json[:data][:attributes].merge!(populate(resource, json)) if populate_associations
            json[:data][:errors] = serialize_errors(resource.errors) if resource.errors.any?
            json
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
