require 'csv'

module Cmor
  module Transports
    module Exports
      class CsvService < Base
        class Result < Base::Result
        end

        private

        def generate_output!
          @output = CSV.generate(headers: true) do |csv|
            csv << resource_attributes_name
            load_collection.each do |resource|
              csv << resource.attributes.values
            end
          end
        end

        def attributes_for_attachment
          {
            io: StringIO.new(@output),
            filename: "export_#{export.id}.csv",
            content_type: 'text/csv'
          }
        end
      end
    end
  end
end