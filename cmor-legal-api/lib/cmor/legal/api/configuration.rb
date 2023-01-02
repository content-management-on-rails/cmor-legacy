module Cmor
  module Legal
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

        define_option :base_controller, default: "ActionController::API"

        define_option :resources_controllers, default: -> {
                                                         [
                                                           Cmor::Legal::Api::PersonalDataController,
                                                           Cmor::Legal::Api::PrivacyPoliciesController
                                                         ]
                                                       }

        define_option :resource_controllers, default: -> { [] }

        define_option :service_controllers, default: -> { [] }

        define_option :sidebar_controllers, default: -> { [] }
      end
    end
  end
end
