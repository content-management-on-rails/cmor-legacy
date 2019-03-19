module Cmor
  module Core
    module Backend
      module Generators
        class InstallGenerator < Rails::Generators::Base
          desc 'Installs the initializer, routes and itsf_backend integration'

          source_root File.expand_path('../templates', __FILE__)

          def generate_controller
            copy_file 'backend_controller.rb', 'app/controllers/backend_controller.rb'
          end

          def generate_initializer
            copy_file 'initializer.rb', 'config/initializers/cmor_core_backend.rb'
          end

          def generate_routes
            route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
          end
        end
      end
    end
  end
end
