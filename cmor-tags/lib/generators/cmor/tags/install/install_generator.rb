module Cmor
  module Tags
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc "Generates the initializer"

        source_root File.expand_path("../templates", __FILE__)

        attr_reader :taggable_factory_name, :taggable_class_names, :tagger_class_names

        def initialize(*args)
          super
          @taggable_factory_name = ENV.fetch("CMOR_TAGS_TAGGABLE_FACTORY_NAME") { ":post" }
          @taggable_class_names = ENV.fetch("CMOR_TAGS_TAGGABLE_CLASS_NAMES") { "%w()" }
          @tagger_class_names = ENV.fetch("CMOR_TAGS_TAGGER_CLASS_NAMEES") { "%w()" }
        end

        def generate_initializer
          template "initializer.rb", "config/initializers/cmor-tags.rb"
        end

        def generate_routes
          route File.read(File.join(File.expand_path("../templates", __FILE__), "routes.source"))
        end
      end
    end
  end
end
