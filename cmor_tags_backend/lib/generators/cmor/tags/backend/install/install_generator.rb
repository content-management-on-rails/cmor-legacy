module Cmor
  module Tags
    module Backend
      module Generators
        class InstallGenerator < Rails::Generators::Base
          desc 'Generates the intializer'

          source_root File.expand_path('../templates', __FILE__)

          attr_accessor :taggable_classes, :tagger_classes

          def initialize(*args)
            super
            @taggable_classes = ENV.fetch('CMOR_TAGS_BACKEND_TAGGABLE_CLASSES') { '%w()' }
            @tagger_classes = ENV.fetch('CMOR_TAGS_BACKEND_TAGGER_CLASSES') { '%w()' }
          end

          def generate_initializer
            template 'initializer.rb', 'config/initializers/cmor_tags_backend.rb'
          end

          def generate_routes
            route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
          end
        end
      end
    end
  end
end
