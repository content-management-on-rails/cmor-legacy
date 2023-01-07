module Cmor
  module Cms
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

      define_option :resources_controllers, default: -> { [] }
      define_option :resource_controllers, default: -> { [] }
      define_option :service_controllers, default: -> { [] }
      define_option :sidebar_controllers, default: -> { [] }
      define_option :navigation_item_properties, default: []
      define_option :default_handlers, default: HashWithIndifferentAccess.new
    end
  end
end
