module Cmor
  module Core
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Installs the frontend controlle and initializer'

        source_root File.expand_path('../templates', __FILE__)

        def generate_controller
          copy_file 'frontend_controller.rb', 'app/controllers/frontend_controller.rb'
        end

        def generate_initializer
          template 'initializer.rb', 'config/initializers/cmor-core.rb'
        end
      end
    end
  end
end