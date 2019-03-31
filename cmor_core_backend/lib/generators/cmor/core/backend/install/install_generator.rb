module Cmor
  module Core
    module Backend
      module Generators
        class InstallGenerator < Rails::Generators::Base
          desc 'Installs the initializer and backend controller'

          source_root File.expand_path('../templates', __FILE__)

          def generate_controller
            copy_file 'backend_controller.rb', 'app/controllers/backend_controller.rb'
          end

          def generate_initializer
            template 'initializer.rb', 'config/initializers/cmor_core_backend.rb'
          end
        end
      end
    end
  end
end
