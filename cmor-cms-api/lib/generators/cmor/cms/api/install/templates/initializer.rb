Rails.application.config.to_prepare do
  Cmor::Cms::Api.configure do |config|
    # Set the base controller for controllers.
    #
    # Default: config.base_controller = '<%= base_controller_class_name %>'
    #
    config.base_controller = "<%= base_controller_class_name %>"

    config.resources_controllers = -> {
      [
        Cmor::Cms::Api::PagesController
      ]
    }

    config.resource_controllers = -> { [] }

    config.service_controllers = -> { [] }

    config.sidebar_controllers = -> { [] }
  end
end
