Cmor::UserArea.configure do |config|
  # Register self to be shown in the backend.
  #
  # Default: config.cmor.administrador.register_engine("Cmor::UserArea::Engine", {})
  #
  config.cmor.administrador.register_engine("Cmor::UserArea::Engine", {})

  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Cmor::UserArea::Backend::UsersController
  #          ]}
  #
  config.resources_controllers = -> {
    [
      Cmor::UserArea::UsersController
    ]
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[
  #            Cmor::UserArea::Backend::CreateDefaultUserServiceController
  #          ]}
  #
  config.service_controllers = -> {
    [
      Cmor::UserArea::CreateDefaultUserServiceController
    ]
  }

  # Set the sidebars, that will be shown in the backend menu.
  #
  # Default: config.sidebar_controllers = -> {[
  #            Cmor::UserArea::Backend::UserSidebarsController
  #          ]}
  #
  config.sidebar_controllers = -> {
    [
      Cmor::UserArea::UserSidebarsController
    ]
  }

  # Allow/disallow new user registrations.
  #
  # default: config.enable_registrations = false
  #
  config.enable_registrations = false

  # Enable/disable two factor authentication.
  #
  # default: config.enable_tfa = -> { true }
  #
  config.enable_tfa = -> { true }

  # Set the options for the one time password.
  #
  # See https://github.com/heapsource/active_model_otp
  #
  # default: config.one_time_password_options = { one_time_backup_codes: true, if: -> { false } }
  #
  config.one_time_password_options = {one_time_backup_codes: true, if: -> { false }}

  # Set the base mailer
  #
  # Default: config.base_mailer = 'ApplicationMailer'
  #
  config.base_mailer = "ApplicationMailer"

  # This is the block, that will be passed to the acts_as_authentic call
  # in the user model.
  #
  # Default: config.acts_as_authentic_options = ->(c) do
  #            config.crypto_provider = Authlogic::CryptoProviders::BCrypt
  #            config.login_field = :email
  #          end
  #
  config.acts_as_authentic_options = lambda do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
    c.login_field = :email
    # How paranoid are you?
    # c.perishable_token_valid_for = 24.hours
  end

  # Application name for mail delivery.
  #
  # Default: config.application_name = Rails.application.class.name.deconstantize
  #
  config.application_name = Rails.application.class.name.deconstantize

  # E-Mail sender address for password reset emails.
  #
  # Default: config.email_from_address = -> { ENV.fetch("CMOR_USER_AREA_SENDER", "no-reply@domain.local") }
  #
  config.email_from_address = -> { ENV.fetch("CMOR_USER_AREA_SENDER", "no-reply@domain.local") }

  # Allow/disallow users to remove their own accounts.
  #
  # default: config.allow_users_to_destroy_self = true
  #
  config.allow_users_to_destroy_self = true

  # Additional rows to show in the current user table.
  #
  # For example, you can intergrate Cmor::Rbac here:
  #
  #     config.current_user_additional_table_rows_proc = lambda do |view, table|
  #       view.render partial: 'cmor/rbac/current_user_additional_table_rows', locals: { table: table }
  #     end
  #
  # default: config.current_user_additional_table_rows_proc = nil
  #
  config.current_user_additional_table_rows_proc = nil
end
