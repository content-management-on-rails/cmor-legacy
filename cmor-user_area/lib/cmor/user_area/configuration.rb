module Cmor
  module UserArea
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

      define_option :enable_registrations, default: false
      define_option :allow_users_to_destroy_self, default: true
      define_option :base_mailer, default: "ApplicationMailer"
      define_option :acts_as_authentic_options, default: ->(config) do
        config.crypto_provider = Authlogic::CryptoProviders::BCrypt
        config.login_field = :email
      end
      define_option :application_name, default: Rails.application.class.name.deconstantize
      define_option :email_from_address, default: -> { ENV.fetch("CMOR_USER_AREA_SENDER", "no-reply@domain.local") }
      define_option :enable_tfa, default: -> { true }
      define_option :one_time_password_options, default: {one_time_backup_codes: true, if: -> { false }}
      define_option :current_user_additional_table_rows_proc, default: nil

      def self.tfa_enabled?
        get(:enable_tfa).call
      end
    end
  end
end
