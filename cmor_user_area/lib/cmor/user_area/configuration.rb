require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Cmor
  module UserArea
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:enable_registrations) { false }
      mattr_accessor(:allow_users_to_destroy_self) { true }
      mattr_accessor(:base_controller) { 'FrontendController' }
      mattr_accessor(:base_mailer) { 'ApplicationMailer' }
      mattr_accessor(:acts_as_authentic_options) do
        ->(config) do
          config.crypto_provider = Authlogic::CryptoProviders::BCrypt
          config.login_field     = :email
        end
      end
      mattr_accessor(:application_name) { Rails.application.class.name.deconstantize }
      mattr_accessor(:email_from_address) do
        lambda do
          ENV['CMOR_USER_AREA_FROM_ADDRESS'] || 'info@example.com'
        end
      end
      mattr_accessor(:current_user_additional_table_rows_proc) { nil }
      mattr_accessor(:after_sign_in_url) { ->(controller) { main_app.root_path } }
      mattr_accessor(:after_sign_out_url) { ->(controller) { main_app.root_path } }
    end
  end
end
