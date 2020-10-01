module Cmor
  module System
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Installs the initializer, routes and backend integration'

        source_root File.expand_path('../templates', __FILE__)

        attr_reader :cmor_system_enable_rack_attack
        attr_reader :cmor_system_enable_active_storage
        attr_reader :cmor_system_enable_delayed_job
        attr_reader :record_factory_name
        attr_reader :record_attachment_name

        def initialize(*args)
          super
          @cmor_system_enable_rack_attack = ENV.fetch('CMOR_SYSTEM_ENABLE_RACK_ATTACK') { false }
          @cmor_system_enable_active_storage = ENV.fetch('CMOR_SYSTEM_ENABLE_ACTIVE_STORAGE') { false }
          @cmor_system_enable_delayed_job = ENV.fetch('CMOR_SYSTEM_ENABLE_DELAYED_JOB') { false }
          @record_factory_name = ENV.fetch('CMOR_SYSTEM_RECORD_FACTORY_NAME') { 'post' }
          @record_attachment_name = ENV.fetch('CMOR_SYSTEM_RECORD_ATTACHMENT_NAME') { 'asset' }
        end

        def generate_initializer
          template 'initializer.rb', 'config/initializers/cmor_system.rb'
        end

        def generate_routes
          route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
        end
      end
    end
  end
end
