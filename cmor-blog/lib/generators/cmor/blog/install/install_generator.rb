module Cmor
  module Blog
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Installs the initializer, routes and itsf_backend integration'

        source_root File.expand_path('../templates', __FILE__)

        attr_reader :user_factory_name
        attr_reader :creator_class_name

        def initialize(*args)
          super
          @user_factory_name = ENV.fetch('CMOR_BLOG_USER_FACTORY_NAME') { 'user' }
          @creator_class_name = ENV.fetch('CMOR_BLOG_CREATOR_CLASS_NAME') { 'User' }
        end

        def generate_initializer
          template 'initializer.rb', 'config/initializers/cmor-blog.rb'
        end

        def generate_routes
          route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
        end
      end
    end
  end
end