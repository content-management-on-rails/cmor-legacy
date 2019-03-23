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
end
