Rails.application.config.to_prepare do
  Cmor::UserArea::Api.configure do |config|
    # Set the base controller for the page controller
    #
    # Default: config.base_controller = '<%= base_controller_class_name %>'
    #
    config.base_controller = "<%= base_controller_class_name %>"

    config.resources_controllers = -> {
      [
        Cmor::UserArea::Api::UsersController
      ]
    }

    config.resource_controllers = -> { [] }

    config.service_controllers = -> { [] }

    config.sidebar_controllers = -> { [] }
  end
end
