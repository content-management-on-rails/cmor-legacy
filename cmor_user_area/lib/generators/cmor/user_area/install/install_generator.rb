module Cmor
  module UserArea
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Generates the initializer'

        source_root File.expand_path('../templates', __FILE__)

        attr_reader :base_controller_class_name

        def initialize(*args)
          super
          @base_controller_class_name = ENV.fetch('BASE_CONTROLLER_CLASS_NAME') { '::ApplicationController' }
        end

        def generate_initializer
          template 'initializer.rb', 'config/initializers/cmor_user_area.rb'
        end

        def generate_routes
          route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
        end

        def add_helpers_to_application_controller
          inject_into_file 'app/controllers/application_controller.rb', before: "\nend" do
            File.read(File.join(File.expand_path('../templates', __FILE__), 'application_controller.source'))
          end
        end

        # def add_default_user
        #   if yes? "Add default user (user@expample.com/password)?"
        #     CreateDefaultUserService.call
        #   end
        # end
      end
    end
  end
end
