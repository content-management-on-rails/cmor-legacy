module Cmor
  module UserArea
    module Frontend
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

        define_option :base_controller, default: "ApplicationController"

        define_option :after_sign_in_url, default: ->(controller) { main_app.root_path }

        define_option :after_sign_out_url, default: ->(controller) { main_app.root_path }
      end
    end
  end
end
