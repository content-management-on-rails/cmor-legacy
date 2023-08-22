module Cmor
  module Core
    module Frontend
      module Generators
        class InstallGenerator < Rails::Generators::Base
          desc 'Installs the initializer, routes and itsf_backend integration'

          source_root File.expand_path('../templates', __FILE__)

          attr_reader :base_controller_class_name

          def initialize(*args)
            super
            @base_controller_class_name = ENV.fetch('CMOR_CORE_FRONTEND_BASE_CONTROLLER_CLASS_NAME') { '::ApplicationController' }
          end

          def generate_controller
            copy_file 'frontend_controller.rb', 'app/controllers/frontend_controller.rb'
          end

          def generate_initializer
            template 'initializer.rb', 'config/initializers/cmor-core-frontend.rb'
          end
        end
      end
    end
  end
end
