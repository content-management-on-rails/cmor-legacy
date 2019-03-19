module Cmor
  module Links
    module Generators
      class LocalesGenerator < Rails::Generators::Base
        desc 'Copies the locale files to your application'

        source_root File.expand_path('../../../../../../config/locales', __FILE__)

        def generate_locales
          copy_file 'cmor.links.category.en.yml', 'config/locales/cmor.links.category.en.yml'
          copy_file 'cmor.links.category.de.yml', 'config/locales/cmor.links.category.de.yml'
          copy_file 'cmor.links.en.yml', 'config/locales/cmor.links.en.yml'
          copy_file 'cmor.links.de.yml', 'config/locales/cmor.links.de.yml'
          copy_file 'cmor.links.link.en.yml', 'config/locales/cmor.links.link.en.yml'
          copy_file 'cmor.links.link.de.yml', 'config/locales/cmor.links.link.de.yml'
        end
      end
    end
  end
end
