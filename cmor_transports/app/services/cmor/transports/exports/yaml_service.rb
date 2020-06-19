module Cmor
  module Transports
    module Exports
      class YamlService < Base
        class Result < Base::Result
        end

        private

        def generate_output!
          @output = load_collection.collect { |r| r.attributes.slice(*resource_attributes) }.to_yaml
        end

        def attributes_for_attachment
          {
            io: StringIO.new(@output),
            filename: "export_#{export.id}.yaml",
            content_type: 'application/x-yaml'
          }
        end
      end
    end
  end
end