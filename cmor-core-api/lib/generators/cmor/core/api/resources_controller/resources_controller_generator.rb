module Cmor
  module Core
    module Api
      module Generators
        # Example:
        #
        #     rails g cmor:core:api:resources_controller -c PostsController
        #
        class ResourcesControllerGenerator < Rails::Generators::Base
          desc 'Generates a resources controller with CRUD actions.'

          source_root File.expand_path('../templates', __FILE__)

          class_option :controller_class, type: 'string', aliases: '-c'
          class_option :resource_class, type: 'string', aliases: '-m'

          def generate_controller
            template 'resources_controller.rb', target_filename
          end

          def generate_routes
            route "resources :#{resources_route_name}"
          end

          private

          def resources_route_name
            @resources_route_name ||= controller_class.gsub(current_engine.chomp('Engine'), '').chomp('Controller').underscore
          end

          def current_engine
            @current_engine ||= File.open("config/routes.rb", &:readline).split('.').first
          end

          def in_engine?
            current_engine != "Rails"
          end

          def target_filename
            @target_filename ||= "app/controllers/#{controller_class.underscore}.rb"
          end

          def controller_class
            @controller_class ||= options[:controller_class]
          end

          def controller_parent_class
            @controller_parent_class ||= if in_engine?
              "#{current_engine.chomp('::Engine')}::Configuration.base_controller.constantize"
            else
              "ActionController::API"
            end
          end

          def resource_class
            controller_class.chomp('Controller').singularize
          end

          def params_name
            resource_class.demodulize.underscore
          end
        end
      end
    end
  end
end
