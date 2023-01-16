module Cmor
  module Seo
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

      def self.set(key, value)
        @values[key] = value
      end

      def self.get(key)
        @values[key]
      end

      define_option :resources_controllers, default: -> { [] }
      define_option :resource_controllers, default: -> { [] }
      define_option :service_controllers, default: -> { [] }
      define_option :sidebar_controllers, default: -> { [] }
      define_option :creator_class_name, default: "User"
      define_option :resources, default: {}
      define_option :current_user_proc, default: ->(controller) { controller.respond_to?(:current_user, true) ? controller.send(:current_user) : nil }

      def self.resources_autocomplete_options
        @values[:resources].each_with_object({}) { |(k, v), m| m[k] = v.fetch(:autocomplete_options) { {} } }
      end

      def self.add_resource(class_name, options = {})
        @values[:resources][class_name] = options
      end

      def self.remove_resource(*class_names)
        class_names.each do |class_name|
          @values[:resources].delete(class_name)
        end
      end
    end
  end
end
