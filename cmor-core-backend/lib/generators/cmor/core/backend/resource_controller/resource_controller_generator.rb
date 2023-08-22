module Cmor
  module Core
    module Backend
      module Generators
        class ResourceControllerGenerator < Rails::Generators::Base
          desc 'Generates a singular resource controller with CRUD actions.'

          source_root File.expand_path('../templates', __FILE__)

          class_option :controller_class, type: 'string', aliases: '-c'
          class_option :resource_class, type: 'string', aliases: '-m'

          def generate_controller
            template 'resource_controller.rb', target_filename
          end

          private

          def target_filename
            "app/controllers/#{controller_class.underscore}.rb"
          end

          def controller_class
            @controller_class ||= options[:controller_class]
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
