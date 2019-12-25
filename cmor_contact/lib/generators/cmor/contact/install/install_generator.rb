module Cmor
  module Contact
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Installs the initializer, routes and backend integration'

        source_root File.expand_path('../templates', __FILE__)

        def generate_initializer
          copy_file 'initializer.rb', 'config/initializers/cmor_contact.rb'
        end

        def generate_routes
          route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
        end
      end
    end
  end
end
