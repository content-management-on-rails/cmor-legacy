Cmor::UserArea::Frontend.configure do |config|
  # Set the base controller
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = "<%= base_controller_class_name %>"

  # Where to redirect to after successful login
  #
  # Default: config.after_sign_in_url = ->(controller) { main_app.root_path }
  #
  config.after_sign_in_url = ->(controller) { main_app.root_path }

  # Where to redirect to after successful logout
  #
  # Default: config.after_sign_out_url = ->(controller) { main_app.root_path }
  #
  config.after_sign_out_url = ->(controller) { main_app.root_path }
end
