module Cmor
  module Links
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
      define_option :link_footer_columns, default: 4
    end
  end
end
