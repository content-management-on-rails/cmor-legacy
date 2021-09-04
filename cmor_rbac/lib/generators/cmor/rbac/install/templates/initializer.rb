Cmor::Rbac.configure do |config|
  # Set the User class.
  #
  # Default: config.user_class_name = '<%= user_class_name %>'
  # 
  config.user_class_name = '<%= user_class_name %>'

  # Factory name to use for users.
  #
  # default: config.user_factory_name = '<%= user_factory_name %>' 
  #
  config.user_factory_name = '<%= user_factory_name %>'

  # Set the path of your default permissions file that will be used by
  # Cmor::Rbac::ImportDefaultPermissionsService
  # 
  # default: config.default_permissions_filename = -> { Rails.root.join('config', 'rbac.yml') }
  # 
  config.default_permissions_filename = -> { Rails.root.join('config', 'rbac.yml') }

  # Where to redirect to when authorization fails.
  #
  # default: config.authorization_failed_location = -> { request.referrer || main_app.root_path }}
  #
  config.authorization_failed_location = -> { request.referrer || main_app.root_path }

  # If set to true and the requested permission is not in the database the action will be
  # authorized.
  #
  # If set to false and the requested permission id not in the database the action will not be
  # authorized.
  #
  # default: config.authorize_if_permission_is_missing = -> { false }
  #
  config.authorize_if_permission_is_missing = -> { false }
end
