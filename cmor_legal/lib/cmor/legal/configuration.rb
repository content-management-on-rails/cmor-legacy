# frozen_string_literal: true

module Cmor
  module Legal
    module Configuration
      def configure
        yield self
      end

      mattr_accessor :resources_controllers do
        -> { [] }
      end

      mattr_accessor :resource_controllers do
        -> { [] }
      end

      mattr_accessor :service_controllers do
        -> { [] }
      end

      mattr_accessor :sidebar_controllers do
        -> { [] }
      end

      mattr_accessor :resources do
        {}
      end

      mattr_accessor(:personal_data_root_classes) { [] }
      mattr_accessor(:filter_personal_data_attributes) { [:email, :firstname, :lastname, :birthdate] }
      mattr_accessor(:enforce_ssl) { true }
      mattr_accessor(:enable_cookie_consent_banner) { true }
      mattr_accessor(:cookies) do
        ->(cookie_store = ::Cmor::Legal::CookieStore.new({})) { [
          ::Cmor::Legal::Cookie.new(identifier: :basic, adjustable: false, default: true,  cookie_store: cookie_store)
        ]}
      end
      mattr_accessor(:cookie_prefix) { "#{Rails.application.class.name.deconstantize.underscore}-eu_gdpr-" }
      mattr_accessor(:cookie_storage) { :cookies }
      mattr_accessor(:integrate_with_cmor_cms) { :auto }

      def self.integrate_with_cmor_cms?
        if integrate_with_cmor_cms == :auto
          begin
            Cmor::Cms
          rescue NameError => e
            false
          end
        else
          integrate_with_cmor_cms
        end
      end

      def personal_data
        @personal_data ||= ::Cmor::Legal::PersonalDataRegistry.instance
      end

      def self.enforce_ssl?
        enforce_ssl
      end

      def self.enable_cookie_consent_banner?
        enable_cookie_consent_banner
      end

      def self.privacy_policy_defaults_for(locale)
        privacy_policy_defaults[locale.to_sym]
      end

      def self.privacy_policy_available_for(locale)
        Cmor::Legal::PrivacyPolicy.where(locale: locale).any?
      end

      def self.filtered_log_parameters
        Rails.application.config.filter_parameters
      end
    end
  end
end
