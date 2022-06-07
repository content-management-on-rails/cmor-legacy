Cmor::Core::Api::Backend.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resources_controllers = -> {[
  #            Cmor::Core::Api::Backend::ApiTokensController
  #          ]}
  # 
  config.resources_controllers = -> {[
    Cmor::Core::Api::Backend::ApiTokensController
  ]}

  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resource_controllers = -> {[]}
  # 
  config.resource_controllers = -> {[]}

  # Set the services, that will be shown in the backend menu.
  # 
  # Default: config.service_controllers = -> {[]}
  # 
  config.service_controllers = -> {[]}

  # Set the sidebars, that will be shown in the backend menu.
  # 
  # Default: config.sidebar_controllers = -> {[]}
  #
  config.sidebar_controllers = -> {[]}
end
