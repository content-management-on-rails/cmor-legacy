Cmor::Transports.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  # 
  # Default: config.resources_controllers = -> {[]}
  # 
  config.resources_controllers = -> {[
    Cmor::Transports::ExportsController,
    Cmor::Transports::OutgoingsController,
    Cmor::Transports::IncomingsController,
    Cmor::Transports::SystemsController
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

  # Configure the api key for incoming transports.
  #
  # Default: config.api_key = ENV.fetch('CMOR_TRANSPORTS_API_KEY') { '<secure-random-string>' }
  #
  config.api_key = ENV.fetch('CMOR_TRANSPORTS_API_KEY') { '<secure-random-string>' }
end
