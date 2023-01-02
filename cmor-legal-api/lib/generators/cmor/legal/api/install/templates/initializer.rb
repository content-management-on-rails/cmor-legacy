Rails.application.config.to_prepare do
  Cmor::Legal::Api.configure do |config|
    # Set the base controller for the page controller
    #
    # Default: config.base_controller = '<%= base_controller_class_name %>'
    #
    config.base_controller = "<%= base_controller_class_name %>"

    config.resources_controllers = -> {
      [
        Cmor::Legal::Api::PersonalDataController,
        Cmor::Legal::Api::PrivacyPoliciesController
      ]
    }

    config.resource_controllers = -> { [] }

    config.service_controllers = -> { [] }

    config.sidebar_controllers = -> { [] }
  end
end
