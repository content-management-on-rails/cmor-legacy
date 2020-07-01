module Cmor
  module Transports
    module Exports
      class JsonService < Base
        class Result < Base::Result
        end

        private

        def generate_output!
          @output = load_collection.collect { |r| build_resource_hash(r) }.to_json
        end

        def attributes_for_attachment
          {
            io: StringIO.new(@output),
            filename: "export_#{export.id}.json",
            content_type: 'application/json'
          }
        end
      end
    end
  end
end