Rails.application.config.to_prepare do
  Cmor::Links::Api.configure do |config|
    # Set the base controller for controllers.
    #
    # Default: config.base_controller = '<%= base_controller_class_name %>'
    #
    config.base_controller = "<%= base_controller_class_name %>"

    config.resources_controllers = -> {
      [
        Cmor::Links::Api::CategoriesController,
        Cmor::Links::Api::LinksController
      ]
    }

    config.resource_controllers = -> { [] }

    config.service_controllers = -> { [] }

    config.sidebar_controllers = -> { [] }
  end
end
