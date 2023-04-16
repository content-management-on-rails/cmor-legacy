Cmor::Restaurant::Api.configure do |config|
  # Set the base controller
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = "<%= base_controller_class_name %>"

  config.resources_controllers = -> {
    [
      Cmor::Restaurant::Api::CategoriesController
    ]
  }

  config.resource_controllers = -> { [] }

  config.service_controllers = -> { [] }
end
