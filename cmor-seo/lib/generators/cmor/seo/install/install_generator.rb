module Cmor
  module Seo
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc "Generates the initializer"

        source_root File.expand_path("../templates", __FILE__)

        attr_reader :creator_class_name

        def initialize(*args)
          super
          @creator_class_name = ENV.fetch("CMOR_SEO_CREATOR_CLASS_NAME") { "User" }
        end

        def generate_initializer
          template "initializer.rb", "config/initializers/cmor-seo.rb"
        end

        def generate_routes
          route File.read(File.join(File.expand_path("../templates", __FILE__), "routes.source"))
        end
      end
    end
  end
end
