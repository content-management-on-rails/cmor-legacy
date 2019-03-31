module Cmor
  module System
    module Backend
      module Generators
        class InstallGenerator < Rails::Generators::Base
          desc 'Installs the initializer, routes and backend integration'

          source_root File.expand_path('../templates', __FILE__)

          attr_reader :cmor_system_backend_enable_active_storage
          attr_reader :cmor_system_backend_enable_delayed_job

          def initialize(*args)
            super
            @cmor_system_backend_enable_active_storage = ENV.fetch('CMOR_SYSTEM_BACKEND_ENABLE_ACTIVE_STORAGE') { false }
            @cmor_system_backend_enable_delayed_job = ENV.fetch('CMOR_SYSTEM_BACKEND_ENABLE_DELAYED_JOB') { false }
          end

          def generate_initializer
            template 'initializer.rb', 'config/initializers/cmor_system_backend.rb'
          end

          def generate_routes
            route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
          end
        end
      end
    end
  end
end
