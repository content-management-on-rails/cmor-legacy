Rails.application.config.to_prepare do
  Cmor::Seo::Api.configure do |config|
    # Set the base controller for all controllers
    #
    # Default: config.base_controller = '<%= base_controller_class_name %>'
    #
    config.base_controller = "<%= base_controller_class_name %>"

    config.resources_controllers = -> { [
      Cmor::Showcase::Api::ItemsController,
      Cmor::Showcase::Api::MetaTagsController
    ] }

    config.resource_controllers = -> { [] }

    config.service_controllers = -> { [] }

    config.sidebar_controllers = -> { [] }
  end
end
