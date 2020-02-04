Cmor::Legal.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.registered_controllers = -> {[
  #              Cmor::Legal::PrivacyPoliciesController,
  #              Cmor::Legal::PersonalDataController
  #          ]}
  # 
  config.resources_controllers = -> {[
    Cmor::Legal::PrivacyPoliciesController,
    Cmor::Legal::PersonalDataController
  ]}
end
