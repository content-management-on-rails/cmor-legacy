module Cmor
  module Blog
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Generates the initializer'

        source_root File.expand_path('../templates', __FILE__)

        attr_reader :base_controller_class_name
        attr_reader :user_factory_name
        attr_reader :creator_class_name

        def initialize(*args)
          super
          @base_controller_class_name = ENV.fetch('BASE_CONTROLLER_CLASS_NAME') { '::ApplicationController' }
          @user_factory_name = ENV.fetch('USER_FACTORY_NAME') { 'user' }
          @creator_class_name = ENV.fetch('CREATOR_CLASS_NAME') { 'User' }
        end

        def generate_initializer
          template 'initializer.rb', 'config/initializers/cmor_blog.rb'
        end

        def generate_routes
          route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
        end
      end
    end
  end
end
