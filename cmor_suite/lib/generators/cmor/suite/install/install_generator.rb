require 'rake'

module Cmor
  module Suite
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Generates the initializer'

        source_root File.expand_path('../templates', __FILE__)

        class_option :excluded_modules, type: 'array', default: [], aliases: '-e'
        class_option :included_modules, type: 'array', default: %w(blog carousels cms contact core files galleries legal links partners rbac seo showcase system tags testimonials user_area), aliases: '-i'

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
            next if m == 'system'
            generate "cmor:#{m}:frontend:install"
          end
        end
        
        def run_backend_generators
          legacy_sub_modules.each do |m|
            generate "cmor:#{m}:backend:install"
          end
          sub_modules.each do |m|
            generate "cmor:#{m}:install"
          end
        end

        def run_migrations_generator
          if options['excluded_modules'].any?
            generate "cmor:suite:migrations", "-i #{options['included_modules'].join(' ')} -e #{options['excluded_modules'].join(' ')}"
          else
            generate "cmor:suite:migrations", "-i #{options['included_modules'].join(' ')}"
          end
        end

        def show_finished_hint
          puts ""
          puts "[Cmor::Suite] Install finished."
        end

        def show_migrate_hint
          puts ""
          puts "[Cmor::Suite] You may want to run 'rails db:migrate' to update your database."
        end

        def show_homepage_generation_hint
          if (legacy_sub_modules + sub_modules).include?('cms')
            puts ""
            puts "[Cmor::Cms] You may want to add default homepages for your locales:"
            puts ""
            puts "    # add default homepages for all of your locales"
            puts "    $> rails cmor:cms:add_homepages"
            puts ""
            puts "    # add default homepages for specific locale(s)"
            puts "    $> rails cmor:cms:add_homepages[en,de]"
          end
        end

        private

        def legacy_sub_modules
          @legacy_sub_modules ||= (options['included_modules'] & %w(blog carousels core cms contact files galleries links rbac tags testimonials user_area)) - options['excluded_modules']
        end

        def sub_modules
          @sub_modules ||= (options['included_modules'] & %w(legal partners seo showcase system)) - options['excluded_modules']
        end
      end
    end
  end
end