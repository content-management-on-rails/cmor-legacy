module Cmor
  module Core
    module Api
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

        define_option :registered_engines, default: {}

        def self.register_engine(class_name, options = {})
          @values[:registered_engines][class_name] = ::Cmor::Core::Api::RegisteredEngine.new(
            class_name: class_name,
            options: options
          )
        end

        def self.registered_engines
          @values[:registered_engines].values
        end
      end
    end
  end
end
