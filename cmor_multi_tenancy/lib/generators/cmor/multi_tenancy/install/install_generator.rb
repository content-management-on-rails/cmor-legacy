module Cmor
  module MultiTenancy
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
          template 'initializer.rb', 'config/initializers/cmor_multi_tenancy.rb'
        end

        def generate_routes
          route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
        end

        def generate_client_model
          copy_file 'app/models/client.rb', 'app/models/client.rb'
        end
      end
    end
  end
end
