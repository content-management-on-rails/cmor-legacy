module Cmor
  module Contact
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

      define_option :contact_request_include_modules, default: -> { [Cmor::Contact::ContactRequest::PhoneConcern] }
      define_option :recipients, default: ->(contact_request) { ENV.fetch("CMOR_CONTACT_RECIPIENTS", "info@domain.local").split(",") }
      define_option :sender, default: ->(contact_request) { ENV.fetch("CMOR_CONTACT_SENDER", "no-reply@domain.local") }
      define_option :whatsapp_number, default: nil
    end
  end
end
