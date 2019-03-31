Cmor::UserArea.configure do |config|
  # Allow/disallow new user registrations.
  # 
  # default: config.enable_registrations = false
  # 
  config.enable_registrations = false

  # Set the base controller
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'

  # Set the base mailer
  #
  # Default: config.base_mailer = 'ApplicationMailer'
  #
  config.base_mailer = 'ApplicationMailer'

  # Where to redirect to after successful login
  #
  # Default: config.after_sign_in_url = ->(controller) { main_app.root_path }
  #
  config.after_sign_in_url = ->(controller) { main_app.root_path }

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
    c.login_field     = :email
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
  # Default: config.email_from_address = 'info@example.com'
  # 
  config.email_from_address = lambda do
    ENV['CMOR_USER_AREA_FROM_ADDRESS'] || 'info@example.com'
  end
  
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
