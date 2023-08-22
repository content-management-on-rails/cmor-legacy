module Cmor
  module Core
    module Api
      module ServiceController
        module SerializationConcern
          extend ActiveSupport::Concern

          class_methods do
            def serializer_class; end
          end

          private

          def serialize_result(service_result)
            serialize_service_result(service_result)
          end
    
          def serialize_errors(errors, full_messages: true)
            errors.as_json(full_messages: full_messages)
          end

          def serialize_messages(messages)
            messages.as_json
          end

          def serialize_service_result(service_result)
            json = { }
            json[:data] = serializable_object(service_result).as_json
            json[:errors] = serialize_errors(service_result.errors) if service_result.errors.any?
            json[:messages] = serialize_messages(service_result.messages) if service_result.messages.any?
            json[:meta] = { attribute_names: service_class.attribute_names.each_with_object({}) { |an, memo| memo[an] = service_class.human_attribute_name(an)  } }
            json
          end

          def serializable_object(service_result)
            if self.class.serializer_class.present?
              self.class.serializer_class.new(service_result, params.permit!.to_h)
            else
              service_result
            end
          end
        end
      end
    end
  end
end
