# frozen_string_literal: true

module Cmor::Audits
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Generates the initializer"

      source_root File.expand_path("../templates", __FILE__)

      attr_reader :base_controller_class_name, :audited_factory_name, :whodunnit_class_name, :whodunnit_find_proc

      def initialize(*args)
        super
        @whodunnit_find_proc = ENV.fetch('CMOR_AUDIT_WHODUNNIT_FIND_PROC') { '->(whodunnit) { Cmor::Audits::Configuration.whodunnit_class_name.constantize.find_by(id: whodunnit) }' }
        @whodunnit_class_name = ENV.fetch('CMOR_AUDIT_WHODUNNIT_CLASS_NAME') { 'User' }
        @audited_factory_name = ENV.fetch('CMOR_AUDIT_AUDITED_FACTORY_NAME') { ':post' }
        @base_controller_class_name = ENV.fetch("BASE_CONTROLLER_CLASS_NAME") { "::ApplicationController" }
      end

      def generate_initializer
        template "initializer.rb", "config/initializers/cmor_audits.rb"
      end

      def generate_routes
        route File.read(File.join(File.expand_path("../templates", __FILE__), "routes.source"))
      end
    end
  end
end
