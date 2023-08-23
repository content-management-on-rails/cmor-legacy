Rails.application.config.to_prepare do
  Cmor::Blog::Api.configure do |config|
    # Set the base controller for controllers.
    #
    # Default: config.base_controller = '<%= base_controller_class_name %>'
    #
    config.base_controller = "<%= base_controller_class_name %>"

    config.resources_controllers = -> {
      [
        Cmor::Blog::Api::PostsController,
        Cmor::Blog::Api::AssetDetailsController,
      ]
    }

    config.resource_controllers = -> { [] }

    config.service_controllers = -> { [] }

    config.sidebar_controllers = -> { [] }
  end
end
