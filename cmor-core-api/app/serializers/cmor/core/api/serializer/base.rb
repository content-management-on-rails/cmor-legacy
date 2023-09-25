module Cmor
  module Core
    module Api
      module Serializer
        class Base
          def initialize(resource, options = {})
            @resource = resource
            @options = options.reverse_merge(populate: [], full_messages: true)
          end
      
          def as_json
            {
              id: @resource.id,
              attributes: @resource.as_json(except: [:id]).merge(associations),
              errors: serialize_errors(@resource)
            }.compact
          end

          def serialize_errors(resource)
            return nil if resource.errors.none?
            resource.errors.as_json(full_messages: @options[:full_messages])
          end

          def associations
            return {} unless @options[:populate]
            @options[:populate].each_with_object({}) do |association_name, memo|
              memo[association_name] = serialize(@resource.send(association_name))
            end
          end
      
          def serialize(resource)
            return resource unless serializer_for(resource)
            if resource.class.ancestors.include?(ActiveRecord::Associations::CollectionProxy)
              resource.map { |r| serializer_for(r).new(r).as_json }
            else
              serializer_for(resource).new(resource).as_json
            end
          end
      
          def serializer_for(resource)
            split_class_name = if resource.class.ancestors.include?(ActiveRecord::Associations::CollectionProxy)
              split_class_name = resource.proxy_association.klass.name.split("::")
            else
              split_class_name = resource.class.name.split("::")
            end
            serializer_class_name = (split_class_name[0..-2] + ["Api"] + ["#{split_class_name[-1]}Serializer"]).join("::")
            serializer_class_name.safe_constantize
          end

          def default_url_options
            @default_url_options ||= Cmor::Core::Api::Configuration.default_url_options.call
          end
        end
      end
    end
  end
end
