Rails.application.config.to_prepare do
  Cmor::Files::Api.configure do |config|
    # Set the base controller for all controllers
    #
    # Default: config.base_controller = '<%= base_controller_class_name %>'
    #
    config.base_controller = "<%= base_controller_class_name %>"

    config.resources_controllers = -> { [
      Cmor::Files::Api::FoldersController,
      Cmor::Files::Api::FileDetailsController
    ] }

    config.resource_controllers = -> { [] }

    config.service_controllers = -> { [] }

    config.sidebar_controllers = -> { [] }
  end
end
