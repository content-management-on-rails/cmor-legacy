module Cmor
  module Cms
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
          template 'initializer.rb', 'config/initializers/cmor_cms.rb'
        end

        def generate_routes
          if Rails.application.routes.url_helpers.respond_to?(:root_path)
            routes_source = 'routes_without_root.source'
          else
            routes_source = 'routes.source'
          end

          inject_into_file 'config/routes.rb', before: "\nend" do
            File.read(File.join(File.expand_path('../templates', __FILE__), routes_source))
          end
        end

        def add_homepages
          begin
            AddHomepagesService.call(locales: [I18n.locale])
          rescue ActiveRecord::StatementInvalid => e
            puts "[Cmor::Cms] Could not generate homepage: #{e.message}"
          end
        end
      end
    end
  end
end
