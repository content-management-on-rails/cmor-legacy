module Cmor
  module Security
    class Configuration
      class << self
        extend Forwardable

        attr_accessor :values

        def define_option(key, default: nil)
          @values[key] = default
          define_singleton_method(key) do
            @values[key]
          end

          define_singleton_method("#{key}=") do |value|
            @values[key] = value
          end
        end
      end

      @values = {}

      define_option :resources_controllers, default: -> {[
        Cmor::Security::AntivirusConfigurationsController
      ]}

      define_option :resource_controllers, default: -> {[]}
      define_option :service_controllers, default: -> {[]}
      define_option :sidebar_controllers, default: -> {[]}
      define_option :antivirus_enabled_models, default: {}

      def self.enable_antivirus_for=(hash)
        hash.collect do |key, options|
          model_class_name, attachment_name = key.split("#")
          @values[:antivirus_enabled_models][model_class_name] = {}
          @values[:antivirus_enabled_models][model_class_name][attachment_name] = options
        end
      end

      def self.antivirus_enabled_models
        @values[:antivirus_enabled_models].collect do |model_class_name, options|
          options.collect do |attachment_name, options|
            Cmor::Security::AntivirusConfiguration.new(model_class_name: model_class_name, attachment_name: attachment_name, options: options)
          end
        end.flatten
      end
    end
  end
end
