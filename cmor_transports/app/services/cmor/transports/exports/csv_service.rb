module Cmor
  module Transports
    module Exports
      class CsvService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
        end

        attr_accessor :export

        private

        def _perform
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

          export.aasm.fire(:success)
        end

        def _after_perform
          export.service_errors = @errors.full_messages.to_sentence
          export.service_messages = @messages.map(&:to_s)
        end

        def save
          raise "foo"
          export.save!
        end

        def generate_output!
          @output = CSV.generate(headers: true) do |csv|
            csv << resource_attributes_name
            load_collection_scope.each do |resource|
              csv << resource.attributes.values
            end
          end
        end

        def attach_output_to_export!
          export.output.attach(attributes_for_attachment)
        end

        def attributes_for_attachment
          {
            io: StringIO.new(@output),
            filename: "export_#{export.id}.csv",
            content_type: 'text/csv'
          }
        end


        def load_collection_scope
          resource_class.find_by_sql(export.query)
        end
        
        def resource_class
          export.root_model.constantize
        end

        def resource_attributes_name
          resource_class.attribute_names
        end
      end
    end
  end
end