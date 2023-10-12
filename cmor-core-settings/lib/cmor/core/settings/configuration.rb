module Cmor
  module Core
    module Settings
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

          def cmor
            Cmor
          end
        end

        @values = {}

        define_option :resources_controllers, default: -> { [] }
        define_option :resource_controllers, default: -> { [] }
        define_option :service_controllers, default: -> { [] }
        define_option :sidebar_controllers, default: -> { [] }
        define_option :store, default: Cmor::Core::Settings::Settable
      end
    end
  end
end
