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

      # define_option :region, default: "us"
      # define_option :api_token, default: "<your-api-token>"

      define_option :resources_controllers, default: -> {[
        Cmor::Security::AntivirusConfigurationsController
      ]}

      define_option :resource_controllers, default: -> {[]}
      define_option :service_controllers, default: -> {[]}
      define_option :sidebar_controllers, default: -> {[]}
      define_option :enable_antivirus_for, default: {}

      # def self.base_url
      #   "https://#{region}-api.tatoru.io"
      # end

      def self.enable_antivirus_for=(hash)
        @antivirus_enabled_models = hash.collect do |key, options|
          model_class_name, attachment_name = key.split("#")
          Cmor::Security::AntivirusConfiguration.new(model_class_name: model_class_name, attachment_name: attachment_name, options: options)
        end
      end

      def self.antivirus_enabled_models
        @antivirus_enabled_models ||= []
      end
    end
  end
end
