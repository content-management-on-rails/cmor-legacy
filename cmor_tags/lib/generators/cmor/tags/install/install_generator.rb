module Cmor
  module Tags
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Generates the initializer'

        source_root File.expand_path('../templates', __FILE__)

        attr_reader :base_controller_class_name, :taggable_factory_name, :taggable_class_names

        def initialize(*args)
          super
          @base_controller_class_name = ENV.fetch('BASE_CONTROLLER_CLASS_NAME') { '::ApplicationController' }
          @taggable_factory_name = ENV.fetch('CMOR_TAGS_TAGGABLE_FACTORY_NAME') { ':post' }
          @taggable_class_names = ENV.fetch('CMOR_TAGS_TAGGABLE_CLASS_NAMES') { '%w()' }
        end

        def generate_initializer
          template 'initializer.rb', 'config/initializers/cmor_tags.rb'
        end

        def generate_routes
          route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
        end

        def add_helpers_to_application_controller
          inject_into_file 'app/controllers/application_controller.rb', before: "\nend" do
            File.read(File.join(File.expand_path('../templates', __FILE__), 'application_controller.source'))
          end
        end
      end
    end
  end
end
