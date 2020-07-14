# frozen_string_literal: true

module Cmor
  module Transports
    module Exports
      class Base < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :export
        end

        attr_accessor :export

        private
        def _perform
          export.aasm.fire(:process)
          generate_output!
          if @errors.any?
            export.aasm.fire(:fail)
            return @result
          end

          attach_output_to_export!
          if @errors.any?
            export.aasm.fire(:fail)
            return @result
          end

          export.aasm.fire(:succeed)
        end

        def after_perform
          @export.service_errors = @errors.full_messages.to_sentence
          @export.service_messages = @messages.map(&:to_s)
          @result.export = @export
        end

        def save
          export.save!
        end

        def generate_output!
          raise "Child class responsibility"
        end

        def attach_output_to_export!
          export.output.attach(attributes_for_attachment)
        end

        def attributes_for_attachment
          raise "Child class responsibility"
        end


        def load_collection
          resource_class.find_by_sql(export.query)
        end

        def resource_class
          export.root_model.constantize
        end

        def resource_attributes
          export.output_attributes || resource_class.attribute_names
        end

        def build_resource_hash(resource)
          resource_attributes.each_with_object({}) do |attr, memo|
            memo[attr] = resource.send(attr)
          end
        end
      end
    end
  end
end
