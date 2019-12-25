require 'rake'

module Cmor
  module Suite
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Generates the initializer'

        source_root File.expand_path('../templates', __FILE__)

        class_option :excluded_modules, type: 'array', default: [], aliases: '-e'

        def initialize(*args)
          ENV['CMOR_RBAC_USER_CLASS_NAME'] ||= 'Cmor::UserArea::User'
          super
        end

        def run_dependency_generators
          generate "administrador:install"
          generate "simple_form:install --bootstrap"
        end

        def generate_route_translator_config
           template 'config/initializers/route_translator.rb', 'config/initializers/route_translator.rb'
        end

        def generate_initializer
          template 'config/initializers/cmor_suite.rb', 'config/initializers/cmor_suite.rb'
        end

        def run_frontend_generators
          generate "cmor:core:frontend:install"
          legacy_sub_modules.each do |m|
            generate "cmor:#{m}:install"
          end
          sub_modules.each do |m|
            generate "cmor:#{m}:frontend:install"
          end
        end
        
        def run_backend_generators
          legacy_sub_modules.each do |m|
            generate "cmor:#{m}:backend:install"
          end
          sub_modules.each do |m|
            next if m == 'system'
            generate "cmor:#{m}:install"
          end
        end

        def run_migrations_generator
          if options['excluded_modules'].any?
            generate "cmor:suite:migrations", "-e #{options['excluded_modules'].join(' ')}"
          else
            generate "cmor:suite:migrations"
          end
        end

        private

        def legacy_sub_modules
          @legacy_sub_modules ||= %w(blog carousels core cms files galleries links rbac system tags testimonials user_area) - options['excluded_modules']
        end

        def sub_modules
          @sub_modules ||= %w(contact partners seo showcase) - options['excluded_modules']
        end
      end
    end
  end
end