# frozen_string_literal: true

module Cmor::Legal
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Generates the initializer"

      source_root File.expand_path("../templates", __FILE__)

      attr_reader :base_controller_class_name

      def initialize(*args)
        super
        @base_controller_class_name = ENV.fetch("BASE_CONTROLLER_CLASS_NAME", "::ApplicationController")
      end

      def generate_initializer
        template "initializer.rb", "config/initializers/cmor-legal.rb"
      end

      def generate_routes
        route File.read(File.join(File.expand_path("../templates", __FILE__), "routes.source"))
      end
    end
  end
end
