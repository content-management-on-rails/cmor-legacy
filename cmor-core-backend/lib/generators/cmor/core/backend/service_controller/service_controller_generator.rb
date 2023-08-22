module Cmor
  module Core
    module Backend
      module Generators
        class ServiceControllerGenerator < Rails::Generators::Base
          desc 'Generates a service controller.'

          source_root File.expand_path('../templates', __FILE__)

          class_option :controller_class, type: 'string', aliases: '-c'
          class_option :service_class, type: 'string', aliases: '-s'

          def generate_controller
            template 'service_controller.rb', target_filename
          end

          private

          def target_filename
            "app/controllers/#{controller_class.underscore}.rb"
          end

          def controller_class
            @controller_class ||= options[:controller_class]
          end

          def service_class
            controller_class.gsub('Controller').singularize.append('Service')
          end

          def params_name
            service_class.demodulize.underscore
          end
        end
      end
    end
  end
end
