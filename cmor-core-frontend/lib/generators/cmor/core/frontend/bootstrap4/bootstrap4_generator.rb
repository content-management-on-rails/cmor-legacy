module Cmor
  module Core
    module Frontend
      module Generators
        class Bootstrap4Generator < Rails::Generators::Base
          desc 'Generates a frontend engine with bootstrap 4 layout'

          source_root File.expand_path('../templates', __FILE__)

          def install_eu_gdpr
            generate "eu_gdpr:install"
          end

          def generate_engine
            empty_directory 'engines/frontend'
            templates_dir = "#{__dir__}/templates/"
            Dir.glob("#{templates_dir}**/*").each do |f|
              next unless File.file?(f)
              f.gsub!(templates_dir, '')
              copy_file f, "engines/frontend/#{f}"
            end
          end

          def add_engine_to_gemfile
            append_to_file 'Gemfile', "\r\ngem 'frontend', path: './engines/frontend'"
          end
        end
      end
    end
  end
end
