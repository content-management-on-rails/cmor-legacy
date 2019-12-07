module Cmor
  module Api
    module Backend
      module Generators
        class InstallGenerator < Rails::Generators::Base
          desc 'Generates the initializer'

          source_root File.expand_path('../templates', __FILE__)

          def generate_intializer
            copy_file 'initializer.rb', 'config/initializers/cmor_api_backend.rb'
          end

          def generate_routes
            route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
          end
        end
      end
    end
  end
end